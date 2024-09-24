import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/screens/LoginView.dart';
import 'package:thraa_najd_mobile_app/services/AuthRepository.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/widgets/custom_button.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_input_text_field.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_logo.dart';

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

  bool isPhoneNumberValid = false;
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
    if (!_validatePhoneNumber(phoneNumberController.text.trim())) return;
    // signup user using our authmethod
    String res = await AuthRepository().signupUser(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      name: nameController.text,
      context: context, // Pass the context here
    );
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
//navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
      );
    } else {
      // show error
      showSnackBar(context, res);
    }
  }

  bool _validatePhoneNumber(String value) {
    final phoneRegExp = RegExp(r"^05\d{8}$");
    if (!phoneRegExp.hasMatch(value)) {
      showSnackBar(context,
          'Invalid phone number. Please enter a valid number starting with 05 and followed by 8 digits.');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kMainColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
        ),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              const CustomLogo(),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'registeration'.tr(),
                      style: TextStyle(
                        fontSize: 16 * (screenSize.width / 375.0),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              TextFieldInput(
                icon: Icons.person,
                textEditingController: nameController,
                hintText: 'writenamehere'.tr(),
                textInputType: TextInputType.text,
                iconSize: screenWidth * 0.06,
                fontSize: screenWidth * 0.04,
              ),
              SizedBox(height: screenHeight * 0.02),
              TextFieldInput(
                icon: Icons.email,
                textEditingController: emailController,
                hintText: 'writeemailhere'.tr(),
                textInputType: TextInputType.text,
                iconSize: screenWidth * 0.06,
                fontSize: screenWidth * 0.04,
              ),
              SizedBox(height: screenHeight * 0.02),
              TextFieldInput(
                icon: Icons.phone,
                textEditingController: phoneNumberController,
                hintText: 'writephonehere'.tr(),
                textInputType: TextInputType.phone,
                iconSize: screenWidth * 0.06,
                fontSize: screenWidth * 0.04,
              ),
              SizedBox(height: screenHeight * 0.02),
              TextFieldInput(
                icon: Icons.lock,
                textEditingController: passwordController,
                hintText: 'writepasslhere'.tr(),
                textInputType: TextInputType.text,
                isPass: false,
                iconSize: screenWidth * 0.06,
                fontSize: screenWidth * 0.04,
              ),
              SizedBox(height: screenHeight * 0.02),
              Custome_button(
                onTap: signupUser,
                text: "register".tr(),
                height: screenHeight * 0.07,
                fontSize: screenWidth * 0.045,
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'haveaccount'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, LoginView.id);
                    },
                    child: Text(
                      'logregesiter'.tr(),
                      style: TextStyle(
                        color: const Color(0xffC7EDE6),
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showSnackBar(BuildContext context, String message) async {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showLoadingIndicator(BuildContext context) {
    // Show a loading indicator in the UI, e.g., using a CircularProgressIndicator
    // You can use a package like 'flutter_spinkit' or create your own custom loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void hideLoadingIndicator(BuildContext context) {
    // Hide the loading indicator
    Navigator.of(context, rootNavigator: true);
  }
}
