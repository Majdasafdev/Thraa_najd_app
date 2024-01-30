import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSwitchButton extends StatefulWidget {
  final BuildContext context;

  LanguageSwitchButton({required this.context});

  @override
  _LanguageSwitchButtonState createState() => _LanguageSwitchButtonState();
}

class _LanguageSwitchButtonState extends State<LanguageSwitchButton> {
  late bool _isEnglish;

  @override
  void initState() {
    super.initState();
    _isEnglish =
        EasyLocalization.of(widget.context)?.locale == Locale('ar', 'AR');
  }

  @override
  Widget build(BuildContext context) {
    final currentContext = widget.context;
    return SwitchListTile(
      title: Text('switchLangs'.tr()),
      value: _isEnglish,
      onChanged: (bool newValue) {
        setState(() {
          _isEnglish = newValue;
        });
        if (_isEnglish) {
          EasyLocalization.of(currentContext)?.setLocale(Locale('en', 'US'));
        } else {
          EasyLocalization.of(currentContext)?.setLocale(Locale('ar', 'AR'));
        }
      },
    );
  }
}
