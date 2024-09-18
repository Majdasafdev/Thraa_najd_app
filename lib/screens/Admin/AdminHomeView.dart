import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/screens/LoginView.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/screens/Admin/AddProductView.dart';
import 'package:thraa_najd_mobile_app/screens/Admin/ManageProductsView.dart';
import 'package:thraa_najd_mobile_app/screens/Admin/AllOrdersView.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_logo.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  static String id = 'AdminHomeView';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kUnActiveColor,
          title: const Text('Admin Panel'),
        ),
        backgroundColor: kSecondaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomLogo(),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Welcome To Admin Panel'),
            ),
            const SizedBox(
              width: double.infinity,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductView.id);
              },
              child: const Text('Add Product'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ManageProducts.id);
              },
              child: const Text('Edit Products'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, OrdersScreen.id);
              },
              child: const Text('View Orders'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginView.id);
              },
              child: const Text('Log out '),
            ),
          ],
        ),
      ),
    );
  }
}
