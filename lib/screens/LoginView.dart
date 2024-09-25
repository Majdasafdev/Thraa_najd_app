import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thraa_najd_mobile_app/providers/admin_mode.dart';
import 'package:thraa_najd_mobile_app/providers/model_hud.dart';
import 'package:thraa_najd_mobile_app/screens/Forget_password.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/widgets/custom_button.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_input_text_field.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_logo.dart';
import 'package:thraa_najd_mobile_app/widgets/snack_bar.dart';
import 'package:thraa_najd_mobile_app/widgets/switch_langs.dart';

import 'Admin/AdminHomeView.dart';
import 'RegistrationView.dart';

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
  Uint8List bytes = Uint8List(0);

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

    return Scaffold(
      backgroundColor: kMainColor,
      body: Consumer<ModelHud>(
        builder: (context, modelHud, _) => ModalProgressHUD(
          inAsyncCall: modelHud.isLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.0 * (screenSize.width / 375.0),
              vertical: 16.0 * (screenSize.height / 800.0),
            ),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  LanguageSwitchButton(context: context),
                  const CustomLogo(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          'logwelcome'.tr(),
                          style: TextStyle(
                            fontSize: 16 * (screenSize.width / 375.0),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10 * (screenSize.height / 800.0)),
                  TextFieldInput(
                    icon: Icons.email,
                    textEditingController: emailController,
                    hintText: 'Enter-your-email'.tr(),
                    textInputType: TextInputType.text,
                    iconSize: 20.0 * (screenSize.width / 375.0),
                    fontSize: 20 * (screenSize.width / 375.0),
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
                      Flexible(
                        child: Text(
                          'remember'.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14 * (screenSize.width / 375.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFieldInput(
                    icon: Icons.lock,
                    textEditingController: passwordController,
                    hintText: 'Enter-your-password'.tr(),
                    textInputType: TextInputType.text,
                    isPass: true,
                    iconSize: 20.0 * (screenSize.width / 375.0),
                    fontSize: 20 * (screenSize.width / 375.0),
                  ),
                  //SizedBox(height: 5 * (screenSize.height / 800.0)),
                  const ForgotPassword(),
                  SizedBox(height: 5 * (screenSize.height / 800.0)),
                  Custome_button(
                    text: 'login'.tr(),
                    onTap: () => loginUser(modelHud),
                    height: 50.0 * (screenSize.height / 800.0),
                    fontSize: 20 * (screenSize.width / 375.0),
                  ),
                  SizedBox(height: 10 * (screenSize.height / 800.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Add this line

                    children: [
                      Flexible(
                        child: Text(
                          'donthaveaccount'.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0 * (screenSize.width / 375.0),
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegistrationView.id);
                        },
                        child: Text(
                          'registerationn'.tr(),
                          style: TextStyle(
                            fontSize: 12.0 * (screenSize.width / 375.0),
                            color: const Color(0xffC7EDE6),
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10 * (screenSize.height / 800.0)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0 * (screenSize.width / 375.0),
                      vertical: 20.0 * (screenSize.height / 800.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeIsAdmin(true);
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
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
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeIsAdmin(false);
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
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
        await Future.delayed(const Duration(seconds: 5));
        await repositoryClient.authRepository.signIn(
          emailController.text.trim(),
          passwordController.text.trim(),
          context,
        );
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
