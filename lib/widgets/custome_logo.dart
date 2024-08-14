import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  // Method to launch WhatsApp
  Future<void> _launchWhatsApp() async {
    const whatsappUrl =
        'https://api.whatsapp.com/send/?phone=966543498392&text&app_absent=0'; // Replace with your WhatsApp number
    final Uri whatsappUri = Uri.parse(whatsappUrl);
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  // Method to make a phone call
  Future<void> _makePhoneCall() async {
    const phoneNumber = 'tel:+966597005649'; // Replace with your phone number
    final Uri phoneUri = Uri.parse(phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not make a call';
    }
  }

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
                iconSize: 26.0 * (screenSize.width / 375.0),
              ),
              SizedBox(width: screenWidth * 0.08), // Space between icons
              IconButton(
                icon: const Icon(FontAwesome5Brands.whatsapp,
                    color: Colors.white), // Use FontAwesome's WhatsApp icon
                onPressed: _launchWhatsApp,
                iconSize: 26.0 * (screenSize.width / 375.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
