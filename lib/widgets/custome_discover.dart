import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/constants.dart';
import 'package:thraa_najd_mobile_app/screens/User/cartScreen.dart';

class CustomeDiscoverbar extends StatelessWidget {
  const CustomeDiscoverbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * .1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'discover'.tr(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CartScreen.id);
                },
                child: Icon(
                  Icons.shopping_cart,
                  color: kSecondaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
