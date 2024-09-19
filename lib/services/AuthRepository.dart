import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/providers/model_hud.dart';
import 'package:thraa_najd_mobile_app/screens/LoginView.dart';
import 'package:thraa_najd_mobile_app/screens/User/HomeView.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';

import '../models/UserModel.dart';
import '../utils/FirebaseConstants.dart';

class AuthRepository extends AbstractRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  final _emailRegExp = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  //SIGN UP
  Future<String> signupUser({
    // Set loading to true when signup starts
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    String res = "Some error Occurred";
    try {
      email = email.trim(); // trim the email
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        // Validate email address
        if (!_emailRegExp.hasMatch(email)) {
          return "Invalid email address";
        }
        showLoadingIndicator(context);

        // register user in auth with email and password
        // ignore: deprecated_member_use
        final user = await _auth.fetchSignInMethodsForEmail(email);
        if (user.isNotEmpty) {
          return "This email is already registered";
        }
        // Set loading to true in context

        // register user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _firestore
            .collection(FirebaseConstants.usersCollection)
            .doc(cred.user!.uid)
            .set(UserModel(
                    id: cred.user!.uid,
                    email: email,
                    name: name,
                    phoneNumber: phoneNumber)
                .toMap());
        // send email verification
        await cred.user!.sendEmailVerification();

        hideLoadingIndicator(context);
        // show a dialog to the user to verify their email
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Verify your email"),
            content: Text(
                "We have sent a verification email to $email. Please verify your email to continue."),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pushNamed(context, LoginView.id);
                },
              ),
            ],
          ),
        );

        /*  // Wait for the user to verify their email
        HERE TO SAVE ONLY VERIFIYNG EMAILS IN USERS COLLECTION
        await cred.user!.reload(); // Reload user to get latest email verification status
        if (!cred.user!.emailVerified) {
          return "Email not verified. Please verify your email.";
        }*/

        return res = "success";
      } else {
        return "Please fill in all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email";
      } else {
        return e.message ?? "An unknown error occurred";
      }
    } catch (err) {
      return err.toString();
    }
  }

// Utility functions to show and hide the loading indicator

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
        email: email.trim(),
        password: password.trim(),
      );
      if (credential.user!.emailVerified) {
        Navigator.pushNamed(context, HomeView.id);
      } else {
        // Check if the user has already been sent a verification email
        if (!credential.user!.emailVerified) {
          await credential.user!.sendEmailVerification();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: "Error",
            desc: "Please check your inbox and activate your email",
          ).show();
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: "Error",
          desc: "User not found",
        ).show();
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: "Error",
          desc: "Wrong password",
        ).show();
      } else if (e.code == 'invalid-email') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: "Error",
          desc: "Invalid email",
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: "Error",
          desc: e.message,
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: "Error",
        desc: "An unknown error occurred",
      ).show();
    }
  }

  Future<void> signOut(ModelHud modelHud) async {
    await firebaseAuth.signOut();
    modelHud.changeisLoading(false);
  }

  void showLoadingIndicator(BuildContext context) {
    // Show a loading indicator in the UI, e.g., using a CircularProgressIndicator
    // You can use a package like 'flutter_spinkit' or create your own custom loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void hideLoadingIndicator(BuildContext context) {
    // Hide the loading indicator
    Navigator.of(context, rootNavigator: true).pop();
  }
}
