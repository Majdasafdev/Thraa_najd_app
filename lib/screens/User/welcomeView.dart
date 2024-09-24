import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thraa_najd_mobile_app/providers/SectionNotifier.dart';
import 'package:thraa_najd_mobile_app/screens/LoginView.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_logo.dart';

class WelcomeView extends StatefulWidget {
  static String id = 'WelcomeView';

  const WelcomeView({super.key});

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
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
        const CustomLogo(),
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
        _buildButton('Wholesale section '),
        _buildButton('Retail section '),
      ],
    );
  }

  Widget _buildButton(String text) {
    SectionNotifier sectionNotifier =
        Provider.of<SectionNotifier>(context, listen: false);

    return ElevatedButton(
      onPressed: () {
        if (text == 'Wholesale section ') {
          sectionNotifier.setSection(true);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
          );
        } else if (text == 'Retail section ') {
          sectionNotifier.setSection(false);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
          );
        }
      },
      child: Text(text),
    );
  }
}
