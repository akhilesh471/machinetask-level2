import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  Future<bool> signInWithGoogle() async {
    try{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
 if(googleUser!=null){
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
      
    );

     await FirebaseAuth.instance.signInWithCredential(credential);
     return true;
 }
 else {
 return false;
 }
    }
    catch (e){
      print(e.toString());
    }
    return true;
  }
}
