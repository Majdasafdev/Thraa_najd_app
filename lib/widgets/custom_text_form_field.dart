import 'package:flutter/material.dart';

class Custom_Form_Text_Foeld extends StatelessWidget {
  Custom_Form_Text_Foeld(
      {this.onChanged, this.hintText, this.obscureText = false});
  Function(String)? onChanged;
  String? hintText;

  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return "The field is required";
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Color(0xff7CAC4A)),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff7CAC4A)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff7CAC4A)),
        ),
      ),
    );
  }
}
