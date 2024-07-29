import 'package:flutter/material.dart';

class Custome_button extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const Custome_button({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: const Color(0xff7CAC4A)),
          width: double.infinity,
          height: 60,
          child: Center(child: Text(text)),
        ));
  }
}
