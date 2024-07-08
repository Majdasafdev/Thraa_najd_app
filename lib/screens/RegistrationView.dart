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
  static String id = 'RegistrationView';

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
    MediaQuery.of(context).size.height * .2;
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
                CustomLogo(),
                SizedBox(height: 75),
                Row(
                  children: [
                    Text(
                      'registeration'.tr(),
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Custom_Form_Text_Foeld(
                  onChanged: (data) {
                    name = data;
                    icon = Icon(Icons.email);
                  },
                  hintText: 'writenamehere'.tr(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Custom_Form_Text_Foeld(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'writeemailhere'.tr(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Custom_Form_Text_Foeld(
                  obscureText: true,
                  onChanged: (data) {
                    passward = data;
                  },
                  hintText: 'writepasslhere'.tr(),
                ),
                const SizedBox(
                  height: 15,
                ),
                Custome_button(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        repositoryClient.authRepository
                            .signUp(email!, passward!, name!);
                        Navigator.pushNamed(context, HomeView.id);

                        //  showSnackBar(
                        //  context,
                        // "Success",
                        //);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, "weakpassward".tr());
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, "email-already-in-use".tr());
                        }
                      } catch (e) {
                        showSnackBar(context, "therewaserr".tr());
                      }
                      isLoading = false;

                      setState(() {});
                    } else {}
                  },
                  text: 'register'.tr(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'haveaccount'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, LoginView.id);
                      },
                      child: Text(
                        'logregesiter'.tr(),
                        style: TextStyle(
                          color: Color(0xffC7EDE6),
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
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: passward!);
  }
}
