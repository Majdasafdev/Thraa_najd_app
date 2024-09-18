import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget desktop;
  final Widget common; // This will be used for both tablet and mobile

  const Responsive({
    super.key,
    required this.desktop,
    required this.common, // Both tablet and mobile will share this layout
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static bool isDesktopWithoutDrawer(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1600;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktop;
        } else {
          return common; // Return the same widget for mobile and tablet
        }
      },
    );
  }
}
