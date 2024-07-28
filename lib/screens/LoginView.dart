import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thraa_najd_mobile_app/screens/Forget_password.dart';
import 'package:thraa_najd_mobile_app/screens/User/HomeView.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/providers/model_hud.dart';
import 'package:thraa_najd_mobile_app/screens/RegistrationView.dart';
import 'package:thraa_najd_mobile_app/widgets/custom_button.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_input_text_field.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_logo.dart';
import 'package:thraa_najd_mobile_app/widgets/snack_bar.dart';
import 'package:thraa_najd_mobile_app/providers/admin_mode.dart';
import 'package:thraa_najd_mobile_app/widgets/switch_langs.dart';
import 'Admin/AdminHomeView.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'loginView';
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final adminPassword = 'Admin123456';
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey();
  String? email;
  String? passward;
  bool? keepMeLoggedIn = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: kMainColor,
      body: Consumer<ModelHud>(
        builder: (context, modelHud, _) => ModalProgressHUD(
          inAsyncCall: modelHud.isLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0 * textScaleFactor,
            ),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  LanguageSwitchButton(context: context),
                  CustomLogo(),
                  SizedBox(height: 5 * textScaleFactor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'logwelcome'.tr(),
                        style: TextStyle(
                          fontSize: 24 * textScaleFactor,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10 * textScaleFactor),
                  TextFieldInput(
                    icon: Icons.email,
                    textEditingController: emailController,
                    hintText: 'Enter your email',
                    textInputType: TextInputType.text,
                  ),
                  Row(
                    children: <Widget>[
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(
                          checkColor: kSecondaryColor,
                          activeColor: kMainColor,
                          value: keepMeLoggedIn,
                          onChanged: (value) {
                            setState(() {
                              keepMeLoggedIn = value;
                            });
                          },
                        ),
                      ),
                      Text(
                        'remember'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  TextFieldInput(
                    icon: Icons.lock,
                    textEditingController: passwordController,
                    hintText: 'Enter your password',
                    textInputType: TextInputType.text,
                    isPass: true,
                  ),
                  SizedBox(
                    height: 8 * textScaleFactor,
                  ),
                  const ForgotPassword(),
                  SizedBox(
                    height: 8 * textScaleFactor,
                  ),
                  Custome_button(
                    text: 'login'.tr(),
                    onTap: () => loginUser(modelHud),
                  ),
                  SizedBox(
                    height: 10 * textScaleFactor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'donthaveaccount'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegistrationView.id);
                        },
                        child: Text(
                          'registerationn'.tr(),
                          style: const TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10 * textScaleFactor),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30 * textScaleFactor,
                      vertical: 10 * textScaleFactor,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeIsAdmin(true);
                            },
                            child: Text(
                              'adminpanel'.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Provider.of<AdminMode>(context).isAdmin
                                    ? kMainColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeIsAdmin(false);
                            },
                            child: Text(
                              'userpanel'.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Provider.of<AdminMode>(context,
                                            listen: true)
                                        .isAdmin
                                    ? Colors.white
                                    : kMainColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginUser(ModelHud modelHud) async {
    if (keepMeLoggedIn == true) {
      keepUserLoggedIn();
    }
    if (formkey.currentState!.validate()) {
      modelHud.changeisLoading(true);
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        await Future.delayed(const Duration(seconds: 5));
        await repositoryClient.authRepository.signIn(
          emailController.text.trim(),
          passwordController.text.trim(),
          context,
        );
        if (credential.user!.emailVerified) {
          Navigator.pushNamed(context, HomeView.id,
              arguments: emailController.text.trim());
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showSnackBar(context, "No user found for that email.".tr());
        } else if (e.code == 'wrong-password') {
          showSnackBar(context, "wrong-password".tr());
        }
      } catch (e) {
        showSnackBar(context, "therewaserr".tr());
      } finally {
        modelHud.changeisLoading(false); // Hide the loading indicator
      }
    } else {}
    _validate(context);
  }

  void _validate(context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisLoading(true);
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      email = emailController.text.trim();
      passward = passwordController.text.trim();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (passward == adminPassword) {
          try {
            await repositoryClient.authRepository.signIn(
              email!.trim(),
              passward!.trim(),
              context,
            );
            Navigator.pushNamed(context, AdminHomeView.id);
          } catch (e) {
            modelhud.changeisLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('invalid entry'),
              ),
            );
          }
        } else {
          modelhud.changeisLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('therewaserr'.tr()),
            ),
          );
        }
      }
    } else {
      modelhud.changeisLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid input'),
        ),
      );
    }
    modelhud.changeisLoading(false);
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('KeepMeLoggedIn', true);
  }
}
