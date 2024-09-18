import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/widgets/snack_bar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  static String id = 'ForgotPassword';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12.0 * (screenSize.width / 375.0),
        vertical: 12.0 * (screenSize.height / 800.0),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            myDialogBox(context);
          },
          child: Text(
            "Forget Password?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0 * (screenSize.width / 375.0),
              color: kUnActiveColor,
            ),
          ),
        ),
      ),
    );
  }

  void myDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenSize = MediaQuery.of(context).size;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20 * (screenSize.width / 375.0)),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(20 * (screenSize.width / 375.0)),
            ),
            padding: EdgeInsets.all(16.0 * (screenSize.width / 375.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxWidth: constraints.maxWidth -
                                  50), // Adjust as needed
                          child: Text(
                            "Forget Your Password",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0 * (screenSize.width / 375.0),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 16.0 * (screenSize.height / 800.0)),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Enter the Email",
                    hintText: "eg abc@gmail.com",
                    labelStyle: TextStyle(
                      fontSize: 14.0 * (screenSize.width / 375.0),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 14.0 * (screenSize.width / 375.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0 * (screenSize.height / 800.0)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0 * (screenSize.height / 800.0),
                    ),
                  ),
                  onPressed: _isLoading ? null : resetPassword,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Send",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0 * (screenSize.width / 375.0),
                            color: Colors.white,
                          ),
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await auth.sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent. Please check your inbox.'),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
