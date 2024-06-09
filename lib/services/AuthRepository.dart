import 'dart:async';

import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thraa_najd_mobile_app/screens/User/home_page.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/widgets/snack_bar.dart';

class AuthRepository extends AbstractRepository {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        // Navigate to the UserInfoScreen with the signed-in user
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        return userCredential;
      } else {
        // Handle the case where googleUser is null (e.g., user canceled the sign-in process)
        throw Exception('User canceled the sign-in process.');
      }
    } on PlatformException catch (e) {
      // Handle the PlatformException
      print('Error signing in with Google: $e');
      if (e.code == 'sign_in_failed') {
        // Specific error handling for the 'sign_in_failed' error code
        // You can display a more user-friendly error message here
        throw Exception('Google Sign-In failed. Please try again.');
      } else {
        // Handle other PlatformException errors
        throw Exception('Google Sign-In error: ${e.code} - ${e.message}');
      }
    } catch (e) {
      // Handle other exceptions
      print('Error signing in with Google: $e');
      throw Exception('Error signing in with Google: $e');
    }
  }
}
