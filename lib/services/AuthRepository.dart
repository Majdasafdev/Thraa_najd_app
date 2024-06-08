import "package:firebase_auth/firebase_auth.dart";
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';

class AuthRepository extends AbstractRepository {
  final _auth = FirebaseAuth.instance;

  Future<dynamic> signUp(String email, String passward) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: passward);

    return authResult;
  }

  Future<dynamic> sigIn(String email, String passward) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: passward);

    return authResult;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  /*
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

   */
}
