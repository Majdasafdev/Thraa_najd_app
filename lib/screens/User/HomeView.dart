import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/models/Category.dart';
import 'package:thraa_najd_mobile_app/models/Product.dart';
import 'package:thraa_najd_mobile_app/screens/User/CartView.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/screens/User/ProductInfo.dart';
import 'package:thraa_najd_mobile_app/screens/User/ProfileView.dart';
import 'package:thraa_najd_mobile_app/screens/LoginView.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_discover.dart';
import 'package:thraa_najd_mobile_app/widgets/product_view.dart';
import 'package:thraa_najd_mobile_app/services/AuthRepository.dart';
import 'dart:convert';

import 'package:thraa_najd_mobile_app/widgets/searchBar.dart';

class HomeView extends StatefulWidget {
  static String id = 'HomePage';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  IList<Product> allProducts = IList();
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 5,
          // ignore: deprecated_member_use
          child: WillPopScope(
            onWillPop: () async => false, // Return false to prevent the pop
            child: Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: kUnActiveColor,
                currentIndex: _bottomBarIndex,
                fixedColor: kUnActiveColor,
                onTap: (value) async {
                  switch (value) {
                    case 0:
                      Navigator.pushNamed(context, ProfileView.id);
                      break;
                    case 1:
                      Navigator.pushNamed(context, HomeView.id);
                      break;
                    case 2:
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "loginView", (route) => false);
                  }

                  setState(
                    () {
                      _bottomBarIndex = value;
                    },
                  );
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: ('Profile'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: ('Store'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.logout),
                    label: ('Sign out'),
                  )
                ],
              ),
              appBar: AppBar(
                // forceMaterialTransparency: true,
                automaticallyImplyLeading: false,
                title:
                    const CustomeDiscoverbar(), // Add the CustomDiscoverbar here
                bottom: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.center,
                  indicatorColor: Colors.white,
                  onTap: (value) {
                    setState(() {
                      _tabBarIndex = value;
                    });
                  },
                  tabs: <Widget>[
                    Text(
                      'nuts'.tr(),
                      style: TextStyle(
                        color: _tabBarIndex == 0 ? kMainColor : kSecondaryColor,
                        fontSize: _tabBarIndex == 0 ? 16 : null,
                      ),
                    ),
                    Text(
                      'spices'.tr(),
                      style: TextStyle(
                        color: _tabBarIndex == 1 ? kMainColor : kSecondaryColor,
                        fontSize: _tabBarIndex == 1 ? 16 : null,
                      ),
                    ),
                    Text(
                      'oils'.tr(),
                      style: TextStyle(
                        color: _tabBarIndex == 2 ? kMainColor : kSecondaryColor,
                        fontSize: _tabBarIndex == 2 ? 16 : null,
                      ),
                    ),
                    Text(
                      'grain'.tr(),
                      style: TextStyle(
                        color: _tabBarIndex == 3 ? kMainColor : kSecondaryColor,
                        fontSize: _tabBarIndex == 3 ? 16 : null,
                      ),
                    ),
                    Text(
                      'other'.tr(),
                      style: TextStyle(
                        color: _tabBarIndex == 4 ? kMainColor : kSecondaryColor,
                        fontSize: _tabBarIndex == 4 ? 16 : null,
                      ),
                    ),
                  ],
                ),
              ),
              body: StreamBuilder<IList<Product>>(
                  stream: repositoryClient.productRepository.getAllProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      allProducts = snapshot.data as IList<Product>;
                      return TabBarView(
                        children: [
                          //NOTE: Changed the products view to the actual categories.
                          ProductsView(
                              category: Category.nuts,
                              allProducts: allProducts
                                  .where((element) =>
                                      (element.category == Category.nuts))
                                  .toIList()),
                          ProductsView(
                              category: Category.spices,
                              allProducts: allProducts
                                  .where((element) =>
                                      (element.category == Category.spices))
                                  .toIList()),
                          ProductsView(
                              category: Category.oils,
                              allProducts: allProducts
                                  .where((element) =>
                                      (element.category == Category.oils))
                                  .toIList()),
                          ProductsView(
                              category: Category.grains,
                              allProducts: allProducts
                                  .where((element) =>
                                      (element.category == Category.grains))
                                  .toIList()),
                          ProductsView(
                              category: Category.other,
                              allProducts: allProducts
                                  .where((element) =>
                                      (element.category == Category.other))
                                  .toIList()),
                        ],
                      );
                    } else {
                      return Center(child: (Text('loading'.tr())));
                    }
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
