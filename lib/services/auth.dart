import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thraa_najd_mobile_app/screens/User/home_page.dart';

class Auth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      // Navigate to the home page
      Navigator.pushNamed(context, HomePage.id);
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }
}
