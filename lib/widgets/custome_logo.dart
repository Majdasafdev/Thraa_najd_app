import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  // Method to launch WhatsApp
  Future<void> _launchWhatsApp(BuildContext context) async {
    const whatsappUrl =
        'https://api.whatsapp.com/send/?phone=966543498392&text&app_absent=0'; // Replace with your WhatsApp number
    final Uri whatsappUri = Uri.parse(whatsappUrl);
    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri);
      } else {
        throw 'Could not launch WhatsApp';
      }
    } on PlatformException catch (e) {
      // Catch platform-specific exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error going to whatsapp link : ${e.message}')),
      );
    } catch (e) {
      // Catch any other exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error going to whatsappp link $e')),
      );
    }
  }

  // Method to make a phone call
  Future<void> _makePhoneCall(BuildContext context) async {
    const phoneNumber = 'tel:+966597005649'; // Replace with your phone number
    final Uri phoneUri = Uri.parse(phoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not make a call';
      }
    } on PlatformException catch (e) {
      // Catch platform-specific exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error making phone call: ${e.message}')),
      );
    } catch (e) {
      // Catch any other exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error making phone call: $e')),
      );
    }
  }

  Future<void> _launchEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'example@example.com', // Replace with the recipient's email address
      query:
          'subject=Hello&body=Message body here', // Optional: subject and body
    );

    try {
      // ignore: deprecated_member_use
      if (await canLaunch(emailUri.toString())) {
        // ignore: deprecated_member_use
        await launch(emailUri.toString());
      } else {
        throw 'Could not launch email client';
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening email client: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening email client: $e')),
      );
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
              backgroundImage: ResizeImage(
                const AssetImage('assets/images/icons/buy_icon.png'),
                width: (screenWidth * 0.375).toInt(), // Cache width adjustment
                height:
                    (screenWidth * 0.375).toInt(), // Cache height adjustment
              ),
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
                onPressed: () async {
                  await _makePhoneCall(context);
                },
                iconSize: 26.0 * (screenSize.width / 375.0),
              ),
              SizedBox(width: screenWidth * 0.08), // Space between icons
              IconButton(
                icon: const Icon(Icons.email,
                    color: Colors.white), // Use FontAwesome's WhatsApp icon
                onPressed: () async {
                  await _launchEmail(context);
                },
                iconSize: 26.0 * (screenSize.width / 375.0),
              ),
              SizedBox(width: screenWidth * 0.08), // Space between icons

              IconButton(
                icon: const Icon(FontAwesome5Brands.whatsapp,
                    color: Colors.white), // Use FontAwesome's WhatsApp icon
                onPressed: () async {
                  await _launchWhatsApp(context);
                },
                iconSize: 26.0 * (screenSize.width / 375.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
