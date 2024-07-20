import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/services/AuthRepository.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/providers/model_hud.dart';
import 'package:thraa_najd_mobile_app/screens/LoginView.dart';
import 'package:thraa_najd_mobile_app/widgets/custom_button.dart';
import 'package:thraa_najd_mobile_app/widgets/custom_text_form_field.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_input_text_field.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool isLoading = false;
  final _emailRegExp = RegExp(
      r"^[a-zA-Z0-9._%+-]+[a-z-AZ0-9.-]+\.[a-zA-Z]{2,}$"); // Declare _emailRegExp here

  GlobalKey<FormState> formkey = GlobalKey();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
  }

  void signupUser() async {
    // set is loading to true.
    setState(() {
      isLoading = true;
    });
    // signup user using our authmethod
    String res = await AuthRepository().signupUser(
      email: emailController.text,
      password: passwordController.text,
      phoneNumber: phoneNumberController.text,
      name: nameController.text,
      context: context, // Pass the context here
    );
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      //navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // show error
      showSnackBar(context, res);
    }
  }

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
                      0.04, // responsive height
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
                TextFieldInput(
                    icon: Icons.person,
                    textEditingController: nameController,
                    hintText: 'Enter your name',
                    textInputType: TextInputType.text),
                TextFieldInput(
                    icon: Icons.email,
                    textEditingController: emailController,
                    hintText: 'Enter your email',
                    textInputType: TextInputType.text),
                const SizedBox(height: 10),
                TextFieldInput(
                  icon: Icons.phone,
                  textEditingController: phoneNumberController,
                  hintText: 'Enter your phone number',
                  textInputType: TextInputType.phone,
                  validator: (value) {
                    String pattern = r'^05[0-9]{8}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value!)) {
                      return 'Please enter a valid phone number (05xxxxxxxx)';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFieldInput(
                  icon: Icons.lock,
                  textEditingController: passwordController,
                  hintText: 'Enter your passord',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                Custome_button(onTap: signupUser, text: "Sign Up"),
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

/*
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
*/
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
