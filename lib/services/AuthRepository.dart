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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends AbstractRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _emailRegExp = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  //SIGN UP
  Future<String> signupUser(
      {required String email,
      required String password,
      required String name,
      required String phoneNumber,
      required BuildContext context}) async {
    String res = "Some error Occurred";
    try {
      email = email.trim(); // trim the email
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        // Validate email address
        if (!_emailRegExp.hasMatch(email)) {
          return "Invalid email address";
        }

        // register user in auth with email and password
        // ignore: deprecated_member_use
        final user = await _auth.fetchSignInMethodsForEmail(email);
        if (user.isNotEmpty) {
          return "This email is already registered";
        }
        // register user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // send email verification
        await cred.user!.sendEmailVerification();

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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );

        // wait for the user to verify their email
        while (!(cred.user!.emailVerified)) {
          await Future.delayed(const Duration(seconds: 2));
        }

        // add user to your  firestore database
        print(cred.user!.uid);
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'name': name,
          'uid': cred.user!.uid,
          'email': email,
          'phoneNumber': phoneNumber,
        });
        res = "success";
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
    return res;
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
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
