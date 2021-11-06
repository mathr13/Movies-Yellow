import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<GoogleSignInAccount> signInWithGoogle() async {
    return await _googleSignIn.signIn();
  }

  Future<GoogleSignInAccount> signOutOfGoogle() async {
    return await _googleSignIn.signOut();
  }

  Future<GoogleSignInAccount> signInWithGoogleSilently() async {
    return await _googleSignIn.signInSilently();
  }

}