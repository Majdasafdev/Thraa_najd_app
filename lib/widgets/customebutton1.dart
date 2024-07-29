import 'package:flutter/material.dart';

class Custome_button1 extends StatelessWidget {
  Custome_button1({super.key, required this.text, this.onTap});
  VoidCallback? onTap;
  String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff7CAC4A),
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.infinity,
        height: 60,
        child: Center(child: Text(text)),
      ),
    );
  }
}
