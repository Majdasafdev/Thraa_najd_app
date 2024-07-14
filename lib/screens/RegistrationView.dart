import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/providers/model_hud.dart';
import 'package:thraa_najd_mobile_app/screens/LoginView.dart';
import 'package:thraa_najd_mobile_app/widgets/custom_button.dart';
import 'package:thraa_najd_mobile_app/widgets/custom_text_form_field.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_logo.dart';
import 'package:thraa_najd_mobile_app/widgets/snack_bar.dart';

import 'User/HomeView.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  static const String id = 'RegistrationView';

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  String? email;

  String? passward;

  String? name;

  Icon? icon;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16), // adjusted padding
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                CustomLogo(),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.1, // responsive height
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'registeration'.tr(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold, // added font weight
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Custom_Form_Text_Foeld(
                  onChanged: (data) {
                    name = data;
                    icon = const Icon(Icons.email);
                  },
                  hintText: 'writenamehere'.tr(),
                ),
                const SizedBox(height: 10),
                Custom_Form_Text_Foeld(
                  onChanged: (data) {
                    email = data;
                    if (!isValidEmail(email!)) {
                      showSnackBar(context, "Invalid email address");
                    } else {
                      showSnackBar(context, "========valid email address");
                    }
                  },
                  hintText: 'writeemailhere'.tr(),
                ),
                const SizedBox(height: 10),
                Custom_Form_Text_Foeld(
                  onChanged: (data) {
                    passward = data;
                  },
                  hintText: 'writephonehere'.tr(),
                ),
                const SizedBox(height: 10),
                Custom_Form_Text_Foeld(
                  onChanged: (data) {
                    passward = data;
                  },
                  hintText: 'writepasslhere'.tr(),
                ),
                const SizedBox(height: 15),
                Custome_button(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      try {
                        repositoryClient.authRepository
                            .signUp(email!, passward!, name!);
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email!, password: passward!);
                        print(
                            '================User created=============: ${credential.user!.uid}');
                        await credential.user!.sendEmailVerification();
                        print(
                            '--------------Verification email sent-------------------');

                        Navigator.pushNamed(context, LoginView.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, "weakpassward".tr());
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, "email-already-in-use".tr());
                        } else {
                          showSnackBar(context, "therewaserr".tr());
                        }
                      } catch (e) {
                        showSnackBar(context, "therewaserr".tr());
                      }
                    } else {}
                  },
                  text: 'register'.tr(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'haveaccount'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16, // adjusted font size
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, LoginView.id);
                      },
                      child: Text(
                        'logregesiter'.tr(),
                        style: const TextStyle(
                          color: Color(0xffC7EDE6),
                          fontSize: 16, // adjusted font size
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> regeisterUser() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: passward!);
      await user.user!.sendEmailVerification().then((value) {
        print(
            '================ Email verification sent! =====================');
      }).catchError((e) {
        print(
            '================ Error sending email verification: ============== $e');
      });
      Navigator.pop(context, LoginView.id);
    } catch (e) {
      // Handle registration error
    }
  }

  bool isValidEmail(String email) {
    // Use a simple email validation pattern
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> showSnackBar(BuildContext context, String message) async {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String getErrorMessage(FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      return "weakpassward".tr();
    } else if (e.code == 'email-already-in-use') {
      return "email-already-in-use".tr();
    } else if (e.code == 'invalid-email') {
      return e.message!;
    } else {
      return "therewaserr".tr();
    }
  }
}
