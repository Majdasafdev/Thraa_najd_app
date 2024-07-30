import 'package:flutter/material.dart';

class Custome_button extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const Custome_button({
    super.key,
    required this.onTap,
    required this.text,
    required double height,
    required double fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02,
        ),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              screenWidth * 0.04,
            ),
          ),
          color: const Color(0xff7CAC4A),
        ),
        width: screenWidth,
        height: screenHeight * 0.08,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
            ),
          ),
        ),
      ),
    );
  }
}
