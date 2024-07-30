import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData? icon;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final double iconSize;
  final double fontSize;

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    this.icon,
    required this.textInputType,
    this.validator,
    this.onChanged,
    required this.iconSize,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
        horizontal: screenWidth * 0.05,
      ),
      child: TextField(
        style: TextStyle(fontSize: fontSize),
        controller: textEditingController,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.black54, size: iconSize),
          hintStyle: TextStyle(
            color: const Color(0xff7CAC4A),
            fontSize: fontSize,
          ),
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff7CAC4A)),
          ),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff7CAC4A), width: 2),
            borderRadius: BorderRadius.circular(screenWidth * 0.075),
          ),
          filled: true,
          fillColor: kUnActiveColor,
          contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenWidth * 0.05,
          ),
        ),
        keyboardType: textInputType,
        obscureText: isPass,
        onChanged: onChanged,
      ),
    );
  }
}
