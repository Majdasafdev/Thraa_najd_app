import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.06),
      child: SizedBox(
        height: screenHeight * 0.2,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              child: CircleAvatar(
                radius: screenWidth * 0.15,
                backgroundColor: Colors.green,
                child: CircleAvatar(
                  radius: screenWidth * 0.375,
                  backgroundColor: Colors.black,
                  backgroundImage:
                      const AssetImage('assets/images/icons/buy_icon.png'),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.13,
              child: Text(
                'thraaNajd'.tr(),
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: screenWidth * 0.06,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
