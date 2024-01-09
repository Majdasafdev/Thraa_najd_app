import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/constants.dart';
import 'package:thraa_najd_mobile_app/screens/Admin/add_product.dart';
import 'package:thraa_najd_mobile_app/screens/Admin/edit_products.dart';
import 'package:thraa_najd_mobile_app/screens/Admin/manage_product.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  static String id = 'AdminHome';

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
            child: Text('Welcome To Admin Panel'),
          ),
          SizedBox(
            width: double.infinity,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text('Add Product'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, ManageProducts.id);
            },
            child: Text('Edit Products'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('View Orders'),
          ),
        ],
      ),
    );
  }
}
