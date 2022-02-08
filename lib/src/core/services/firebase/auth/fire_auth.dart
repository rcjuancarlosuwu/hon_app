import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:hon_app/src/core/constants/constants.dart';
import 'package:hon_app/src/core/errors/errors.dart';
import 'package:hon_app/src/core/services/firebase/auth/google_auth.dart';
import 'package:hon_app/src/core/services/local/local_data_source.dart';
import 'package:hon_app/src/core/services/remote/remote_data_source.dart';
import 'package:hon_app/src/core/type_defs/type_defs.dart';

abstract class IFireAuth {
  Stream<User?> currentUser();
  FutureEitherVoid signIn();
  FutureEitherVoid signOut();
}

class FireAuth implements IFireAuth {
  FireAuth({
    required this.firebaseAuth,
    required this.googleAuth,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final FirebaseAuth firebaseAuth;
  final GoogleAuth googleAuth;
  final ILocalDataSource localDataSource;
  final IRemoteDataSource remoteDataSource;

  @override
  Stream<User?> currentUser() => firebaseAuth.authStateChanges();

  @override
  FutureEitherVoid signIn() async {
    try {
      final credential = await googleAuth.signInWithGoogle();
      if (credential != null) {
        await firebaseAuth.signInWithCredential(credential);
        final token = await firebaseAuth.currentUser?.getIdToken();
        final refreshToken = await remoteDataSource.signInGoogle(token!);
        localDataSource.saveRefreshToken(refreshToken);
        return right(null);
      } else {
        throw AuthException('Sign in aborted by user');
      }
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure(e.message ?? authExceptionMessage));
    } on BaseException catch (e) {
      return left(AuthFailure(e.message));
    } on Exception catch (_) {
      return left(AuthFailure(authExceptionMessage));
    }
  }

  @override
  FutureEitherVoid signOut() async {
    try {
      await googleAuth.signOut();
      await firebaseAuth.signOut();
      final refreshToken = localDataSource.getRefreshToken();
      await remoteDataSource.revokeToken(refreshToken.refreshToken!);
      return right(null);
    } on Exception catch (_) {
      return left(AuthFailure(signOutExceptionMessage));
    }
  }
}
