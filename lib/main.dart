import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thraa_najd_mobile_app/constants.dart';
import 'package:thraa_najd_mobile_app/providers/cartItem.dart';
import 'package:thraa_najd_mobile_app/screens/Admin/oreder_deatiels.dart';
import 'package:thraa_najd_mobile_app/screens/User/cartScreen.dart';
import 'package:thraa_najd_mobile_app/screens/User/product_info.dart';
import 'package:thraa_najd_mobile_app/screens/User/profileUserScreen.dart';
import 'package:thraa_najd_mobile_app/screens/User/welcomeScreen.dart';
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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en', 'US'),
      Locale('ar', 'AR'),
    ],
    path: 'assets/translations',
    child: ThraaNajdApp(),
  ));
}

class ThraaNajdApp extends StatelessWidget {
  bool isUserLoggedIn = false;

  ThraaNajdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: const Scaffold(
                body: Center(
                  child: Text('Loading....'),
                ),
              ),
            ),
          );
        } else {
          isUserLoggedIn = snapshot.data?.getBool(kKeepMeLoggedIn) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ModelHud>(
                create: (context) => ModelHud(),
              ),
              ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),
              ChangeNotifierProvider<AdminMode>(
                create: (context) => AdminMode(),
              )
            ],
            child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              initialRoute: isUserLoggedIn ? WelcomePage.id : WelcomePage.id,
              routes: {
                OrderDeatiels.id: (context) => OrderDeatiels(),
                loginPage.id: (context) => const loginPage(),
                RegisterPage.id: (context) => RegisterPage(),
                HomePage.id: (context) => const HomePage(),
                AdminHome.id: (context) => const AdminHome(),
                AddProduct.id: (context) => AddProduct(),
                ManageProducts.id: (context) => ManageProducts(),
                OrdersScreen.id: (context) => OrdersScreen(),
                EditProducts.id: (context) => EditProducts(),
                CartScreen.id: (context) => const CartScreen(),
                ProductInfo.id: (context) => ProductInfo(),
                WelcomePage.id: (context) => const WelcomePage(),
                ProfilePage.id: (context) => const ProfilePage(),

                //WelcomeScreen
              },
            ),
          );
        }
      },
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
