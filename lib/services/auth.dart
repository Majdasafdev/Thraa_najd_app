import "package:firebase_auth/firebase_auth.dart";

class Auth {
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
}
