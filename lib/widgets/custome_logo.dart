import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double iconSize;
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      // Increased height to accommodate all content
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: screenWidth * 0.15,
            backgroundColor: Colors.green,
            child: CircleAvatar(
              radius: screenWidth * 0.375,
              backgroundColor: Colors.black,
              backgroundImage:
                  const AssetImage('assets/images/icons/buy_icon.png'),
            ),
          ),
          Text(
            'thraaNajd'.tr(),
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: screenWidth * 0.06,
              color: Colors.white,
            ),
          ),
          // Space between text and icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Feather.phone,
                    color: Colors.white), // Use Feather's phone icon
                onPressed: _makePhoneCall,
              ),
              SizedBox(width: screenWidth * 0.08), // Space between icons
              IconButton(
                icon: const Icon(FontAwesome5Brands.whatsapp,
                    color: Colors.white), // Use FontAwesome's WhatsApp icon
                onPressed: _launchWhatsApp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
