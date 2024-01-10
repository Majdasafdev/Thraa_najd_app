import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thraa_najd_mobile_app/constants.dart';
import 'package:thraa_najd_mobile_app/firebase_options.dart';
import 'package:thraa_najd_mobile_app/screens/User/product_info.dart';
import 'package:thraa_najd_mobile_app/screens/login_screen.dart';
import 'package:thraa_najd_mobile_app/screens/registeration_page.dart';
import 'providers/admin_mode.dart';
import 'providers/model_hud.dart';
import 'screens/Admin/add_product.dart';
import 'screens/Admin/admin_home.dart';
import 'screens/Admin/manage_product.dart';
import 'screens/Admin/edit_products.dart';
import 'screens/Admin/orders_screen.dart';
import 'screens/User/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ThraaNajdApp());
}

class ThraaNajdApp extends StatefulWidget {
  const ThraaNajdApp({super.key});

  @override
  State<ThraaNajdApp> createState() => _ThraaNajdAppState();
}

class _ThraaNajdAppState extends State<ThraaNajdApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
                    seedColor: Color.fromARGB(206, 206, 204, 204))
                .copyWith(background: Colors.white)),
        initialRoute: loginPage.id,
        routes: {
          loginPage.id: (context) => loginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          HomePage.id: (context) => HomePage(),
          AdminHome.id: (context) => AdminHome(),
          AddProduct.id: (context) => AddProduct(),
          ManageProducts.id: (context) => ManageProducts(),
          OrdersScreen.id: (context) => OrdersScreen(),
          EditProducts.id: (context) => EditProducts(),
          ProductInfo.id: (context) => ProductInfo(),
        },
      ),
    );
  }
}
