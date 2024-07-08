import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thraa_najd_mobile_app/screens/User/HomeView.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/providers/model_hud.dart';
import 'package:thraa_najd_mobile_app/screens/RegistrationView.dart';
import 'package:thraa_najd_mobile_app/services/AuthRepository.dart';
import 'package:thraa_najd_mobile_app/widgets/custom_button.dart';
import 'package:thraa_najd_mobile_app/widgets/custom_text_form_field.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_logo.dart';
import 'package:thraa_najd_mobile_app/widgets/snack_bar.dart';
import 'package:thraa_najd_mobile_app/providers/admin_mode.dart';
import 'package:thraa_najd_mobile_app/widgets/switch_langs.dart';
import 'Admin/AdminHomeView.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'loginView';
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();
  String? email;
  String? passward;

  final adminPassword = 'Admin123456';
  bool? keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                LanguageSwitchButton(context: context),
                CustomLogo(),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'logwelcome'.tr(),
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Custom_Form_Text_Foeld(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'email'.tr(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: <Widget>[
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(
                          checkColor: kSecondaryColor,
                          activeColor: kMainColor,
                          value: keepMeLoggedIn,
                          onChanged: (value) {
                            setState(
                              () {
                                keepMeLoggedIn = value;
                              },
                            );
                          },
                        ),
                      ),
                      Text(
                        'remember'.tr(),
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Custom_Form_Text_Foeld(
                  obscureText: true,
                  onChanged: (data) {
                    passward = data;
                  },
                  hintText: 'password'.tr(),
                ),
                const SizedBox(
                  height: 15,
                ),
                Custome_button(
                    onTap: () async {
                      if (keepMeLoggedIn == true) {
                        keepUserLoggedIn();
                      }
                      if (formkey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await repositoryClient.authRepository
                              .signIn(email!, passward!);
                          Navigator.pushNamed(context, LoginView.id,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                                context, "No user found for that email.".tr());
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context,
                                "Wrong password provided for that user.".tr());
                          }
                        } catch (e) {
                          showSnackBar(context, "therewaserr".tr());
                        }
                        isLoading = false;

                        setState(() {});
                      } else {}
                      _validate(context);
                    },
                    text: 'login'.tr()),
                const SizedBox(
                  height: 10,
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                                    : Colors.white),
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
                                    : kMainColor),
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
    );
  }

  void _validate(context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisLoading(true);
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (passward == adminPassword) {
          try {
            await repositoryClient.authRepository
                .signIn(email!.trim(), passward!.trim());
            Navigator.pushNamed(context, AdminHomeView.id);
          } catch (e) {
            modelhud.changeisLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              ),
            );
          }
        } else {
          modelhud.changeisLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('therewaserr'.tr()),
          ));
        }
      } else {
        try {
          await repositoryClient.authRepository
              .signIn(email!.trim(), passward!.trim());
          Navigator.pushNamed(context, HomeView.id);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
          ));
        }
      }
    }
    modelhud.changeisLoading(false);
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn!);
  }
}
