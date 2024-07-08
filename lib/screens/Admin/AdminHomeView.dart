import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/screens/Admin/AddProductView.dart';
import 'package:thraa_najd_mobile_app/screens/Admin/ManageProductsView.dart';
import 'package:thraa_najd_mobile_app/screens/Admin/AllOrdersView.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  static String id = 'AdminHomeView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
        ],
      ),
    );
  }
}
