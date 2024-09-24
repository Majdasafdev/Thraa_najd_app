import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:snackbar/snackbar.dart';
import 'package:thraa_najd_mobile_app/main.dart';
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
          title: Text('admin-Panel'.tr()),
        ),
        backgroundColor: kSecondaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomLogo(),
            ElevatedButton(
              onPressed: () {},
              child: Text('Welcome-Admin-Panel'.tr()),
            ),
            const SizedBox(
              width: double.infinity,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductView.id);
              },
              child: Text('add-Product'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ManageProducts.id);
              },
              child: Text('edit-Products'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, OrdersScreen.id);
              },
              child: Text('view-Orders'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginView.id);
              },
              child: Text('logOut'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
