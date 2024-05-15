import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/constants.dart';
import 'package:thraa_najd_mobile_app/screens/User/CartScreen.dart';
import 'package:thraa_najd_mobile_app/screens/User/home_page.dart';

class WelcomePage extends StatefulWidget {
  static String id = 'WelcomePage';

  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kUnActiveColor,
        toolbarHeight: 100,
      ),
      backgroundColor: kUnActiveColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _buildGrid(),
        _buildAvatar(),
      ],
    );
  }

  Widget _buildGrid() {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _buildButton('Wholesale'),
        _buildButton('Retail'),
      ],
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'Wholesale') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartScreen()),
          );
        } else if (text == 'Retail') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      },
      child: Text(text),
    );
  }

  Widget _buildAvatar() {
    return const CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage('assets/images/icons/buy_icon.png'),
    );
  }
}
