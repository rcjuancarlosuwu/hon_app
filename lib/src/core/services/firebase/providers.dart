import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hon_app/src/core/services/firebase/auth/auth_user.dart';

import '../local/providers.dart';
import '../remote/providers.dart';
import 'auth/fire_auth.dart';
import 'auth/google_auth.dart';

export 'firebase_options.dart';

final googleSignInProvider = Provider((_) => GoogleSignIn());
final firebaseAuthProvider = Provider((_) => FirebaseAuth.instance);
final firebaseFirestoreProvider = Provider((_) => FirebaseFirestore.instance);
final userCollectionProvider = Provider((ref) {
  return ref.watch(firebaseFirestoreProvider).collection('users');
});

final googleAuthProvider = Provider(
  (ref) => GoogleAuth(googleSignIn: ref.watch(googleSignInProvider)),
);

final fireAuthProvider = Provider<FireAuth>((ref) {
  return FireAuth(
    googleAuth: ref.watch(googleAuthProvider),
    firebaseAuth: ref.watch(firebaseAuthProvider),
    localDataSource: ref.watch(localDataSourceProvider),
    remoteDataSource: ref.watch(remoteDataSourceProvider),
  );
});

final authUserStreamProvider = StreamProvider<AuthUser>(
  (ref) => ref.watch(fireAuthProvider).currentUser().map((user) => AuthUser(
        uid: user?.uid ?? '',
        email: user?.email ?? '',
        name: user?.displayName ?? '',
        photoURL: user?.photoURL ?? '',
      )),
);

final userProvider = Provider<AuthUser>((ref) {
  return ref.watch(authUserStreamProvider).asData!.value;
});
