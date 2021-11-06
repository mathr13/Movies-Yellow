import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poc_yellowc/services/auth-services.dart';

class UserController extends GetxController {

  final AuthServices _authServices = AuthServices();
  GoogleSignInAccount googleUser;
  var progressLoader = false.obs;

  bool get isUserAuthenticated => googleUser != null;

  UserController() {
    backgroundSignIn();
  }

  Future<bool> signIn() async {
    progressLoader.value = true;
    googleUser = await _authServices.signInWithGoogle();
    progressLoader.value = false;
    return googleUser != null;
  }

  Future<bool> signOut() async {
    progressLoader.value = true;
    googleUser = await _authServices.signOutOfGoogle();
    progressLoader.value = false;
    return googleUser == null;
  }

  Future<bool> backgroundSignIn() async {
    progressLoader.value = true;
    googleUser = await _authServices.signInWithGoogleSilently();
    progressLoader.value = false;
    return googleUser != null;
  }

}