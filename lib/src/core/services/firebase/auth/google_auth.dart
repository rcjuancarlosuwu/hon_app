import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  const GoogleAuth({
    required GoogleSignIn googleSignIn,
  }) : _googleSignIn = googleSignIn;

  final GoogleSignIn _googleSignIn;

  Future<OAuthCredential?> signInWithGoogle() async {
    final result = await _googleSignIn.signIn();

    if (result == null) return null;

    final authentication = await result.authentication;
    return GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );
  }

  Future<void> signOut() async => await _googleSignIn.signOut();
}
