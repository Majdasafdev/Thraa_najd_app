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
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;

        final horizontalPadding = screenWidth * 0.1;

        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth < 600 ? 16.0 : 32.0),
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
                  fontSize: screenWidth < 600 ? 14.0 : 16.0,
                  color: kUnActiveColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void myDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Forget Your Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter the Email",
                    hintText: "eg abc@gmail.com",
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  onPressed: _isLoading ? null : resetPassword,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Send",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
