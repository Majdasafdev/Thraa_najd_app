import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Container(
        height: MediaQuery.of(context).size.height * .2,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              //     left: 0,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.green,
                child: CircleAvatar(
                  radius: 150,
                  backgroundColor: Colors.black,
                  backgroundImage:
                      AssetImage('assets/images/icons/buy_icon.png'),
                ),
              ),
            ),
            Positioned(
              top: 110,
              //   left: 0,
              child: Text(
                'thraaNajd'.tr(),
                style: TextStyle(
                    fontFamily: 'Pacifico', fontSize: 25, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
