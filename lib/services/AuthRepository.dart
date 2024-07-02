import 'package:easy_localization/easy_localization.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:thraa_najd_mobile_app/models/UserModel.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/FirebaseConstants.dart';

class AuthRepository extends AbstractRepository {
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
    if (userModel.phoneNumber!.length != 10 ||
        userModel.phoneNumber!.length != 9 ||
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
