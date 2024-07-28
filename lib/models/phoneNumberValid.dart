import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  final BuildContext context;

  PhoneNumberFormatter(this.context);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final phoneNumberRegex = RegExp(r'^05\d{8}$');
    if (phoneNumberRegex.hasMatch(newValue.text)) {
      return newValue;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid phone number starting with 05'),
        ),
      );
      return oldValue;
    }
  }
}
