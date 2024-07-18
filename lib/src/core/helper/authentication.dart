import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_init/src/const/constant.dart';

class AuthRepo{

  Future<dynamic> signInWithGoogle() async {
    try { 
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        clientId: '32644345180-bqq5rcks2goi5rtjjmkkn8okt5fh79e1.apps.googleusercontent.com'
      ).signIn();
      final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      await  userRef.doc(userCredential.user!.uid).set({
      'id': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'phoneNo': userCredential.user!.phoneNumber.toString(),
      'imageUrl': userCredential.user!.photoURL,
      'name' : userCredential.user!.displayName,
    });
      return userCredential;
      
    } on Exception catch (e) {
      print('Exception->$e');
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await firebaseAuth.signOut();
      await GoogleSignIn().signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

}