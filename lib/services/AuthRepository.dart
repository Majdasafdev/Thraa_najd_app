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
}
