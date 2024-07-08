import 'dart:async';

import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thraa_najd_mobile_app/screens/User/HomeView.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/widgets/snack_bar.dart';

import '../models/UserModel.dart';
import '../utils/FirebaseConstants.dart';

class AuthRepository extends AbstractRepository {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<bool> signUp(String email, String password, String name) async {
    final authResult = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (authResult.user == null) {
      return false;
    }

    await firebaseFirestore
        .collection(FirebaseConstants.usersCollection)
        .doc(authResult.user!.uid)
        .set(UserModel(email: email, name: name).toMap());

    return true;
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

  Future<dynamic> signIn(String email, String passward) async {
    final authResult = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: passward);

    return authResult;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
