
/**
import 'package:flutter/material.dart';
import 'package:thraa_najd_app/constants.dart';
import 'package:thraa_najd_app/widgets/custom_text_field.dart';
import 'package:thraa_najd_app/widgets/custome_logo.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  static String id = 'SignupScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            CustomLogo(),
            CustomTextField(hint: "Enter your name", icon: Icons.perm_identity),
            SizedBox(height: height * .02),
            CustomTextField(hint: "Enter your Email", icon: Icons.email),
            SizedBox(height: height * .02),
            CustomTextField(hint: "Enter your Passward", icon: Icons.lock),
            SizedBox(height: height * .05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 74, 71, 71)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Set the border radius here
                    ),
                  ),
                ),
                onPressed: () {
                  if (_globalKey.currentState!.validate()) {
                    //
                  }
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: height * .05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Do you have an account?   ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text('Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
**/