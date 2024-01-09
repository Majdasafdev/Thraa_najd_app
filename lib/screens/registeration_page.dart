import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:thraa_najd_mobile_app/constants.dart';
import 'package:thraa_najd_mobile_app/providers/model_hud.dart';
import 'package:thraa_najd_mobile_app/screens/login_screen.dart';
import 'package:thraa_najd_mobile_app/widgets/custom_button.dart';
import 'package:thraa_najd_mobile_app/widgets/custom_text_form_field.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_logo.dart';
import 'package:thraa_najd_mobile_app/widgets/snack_bar.dart';

import 'User/home_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                const Row(
                  children: [
                    Text(
                      'Welcome to the regitsteriation page',
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
                  hintText: 'Write your full name here',
                ),
                const SizedBox(
                  height: 10,
                ),
                Custom_Form_Text_Foeld(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Write your E-mail here',
                ),
                const SizedBox(
                  height: 10,
                ),
                Custom_Form_Text_Foeld(
                  obscureText: true,
                  onChanged: (data) {
                    passward = data;
                  },
                  hintText: 'Write your full password here',
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
                        await regeisterUser();
                        Navigator.pushNamed(context, HomePage.id);

                        //  showSnackBar(
                        //  context,
                        // "Success",
                        //);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, "Weak passward");
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, "email-already-in-use");
                        }
                      } catch (e) {
                        showSnackBar(context, "There was an error");
                      }
                      isLoading = false;

                      setState(() {});
                    } else {}
                  },
                  text: 'Register',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, loginPage.id);
                      },
                      child: Text(
                        'Login',
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
