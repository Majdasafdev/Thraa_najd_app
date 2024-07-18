import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thraa_najd_mobile_app/screens/LoginView.dart';
import 'package:thraa_najd_mobile_app/screens/User/CartView.dart';
import 'package:thraa_najd_mobile_app/screens/User/HomeView.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/widgets/snack_bar.dart';

import '../models/UserModel.dart';
import '../utils/FirebaseConstants.dart';

class AuthRepository extends AbstractRepository {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<dynamic> signUp(String email, String passward) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: passward);

    // Get the user
    User? user = authResult.user;

    // Send email verification link only once
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }

    return authResult;
  }

  Stream<UserModel> getCurrentUserInfo() {
    return firebaseFirestore
        .collection(FirebaseConstants.usersCollection)
        .doc(firebaseAuth.currentUser!.uid)
        .snapshots()
        .asyncMap((event) => UserModel.fromMap(event.data()!));
  }

  Future<bool> editUserName(String name) async {
    await firebaseFirestore
        .collection(FirebaseConstants.usersCollection)
        .doc(firebaseAuth.currentUser!.uid)
        .set({UserModel.firebaseName: name});
    return true;
  }

  Future<bool> editUserInfo(UserModel userModel) async {
    if (userModel.name.isEmpty) {
      throw Exception("Invalid Name");
    }
    if (userModel.phoneNumber!.isEmpty) {
      throw Exception("Invalid Phone Number");
    }
    if ((userModel.phoneNumber!.length != 10 &&
            userModel.phoneNumber!.length != 9) ||
        !userModel.phoneNumber!.startsWith("05")) {
      throw Exception("Invalid Phone Number");
    }
    await firebaseFirestore
        .collection(FirebaseConstants.usersCollection)
        .doc(firebaseAuth.currentUser!.uid)
        .set(userModel.toMap());
    return true;
  }

  Future<bool> updateEmail(String email) async {
    return true;
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user!.emailVerified) {
        Navigator.pushNamed(context, HomeView.id);
      } else {
        // Check if the user has already been sent a verification email
        final userDoc = await firebaseFirestore
            .collection(FirebaseConstants.usersCollection)
            .doc(credential.user!.uid)
            .get();
        if (userDoc.exists && userDoc.get('emailVerifiedSent')) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: "Error",
            desc: "Please check your inbox and activate your email",
          ).show();
        } else {
          await credential.user!.sendEmailVerification();
          await userDoc.reference.update({'emailVerifiedSent': true});
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: "Error",
            desc: "Go to your inbox and activate your email",
          ).show();
        }
      }
    } catch (e) {
      // handle sign in error
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
