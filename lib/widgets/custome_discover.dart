import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/screens/User/CartView.dart';

class CustomeDiscoverbar extends StatelessWidget {
  const CustomeDiscoverbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Material(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'discover'.tr(),
                  style: TextStyle(
                      fontSize: 16 * (screenSize.width / 375.0),
                      fontWeight: FontWeight.bold,
                      color: kSecondaryColor),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CartScreen.id);
                },
                child: const Icon(
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
