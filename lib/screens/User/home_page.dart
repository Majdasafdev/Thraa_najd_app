import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thraa_najd_mobile_app/models/Category.dart';
import 'package:thraa_najd_mobile_app/models/Product.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/utils/function.dart';
import 'package:thraa_najd_mobile_app/models/oldProduct.dart';
import 'package:thraa_najd_mobile_app/screens/User/product_info.dart';
import 'package:thraa_najd_mobile_app/screens/User/profileUserScreen.dart';
import 'package:thraa_najd_mobile_app/screens/login_screen.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_discover.dart';
import 'package:thraa_najd_mobile_app/widgets/product_view.dart';
import 'package:thraa_najd_mobile_app/services/AuthRepository.dart';
import 'package:thraa_najd_mobile_app/services/store.dart';
import 'dart:convert';

import 'package:thraa_najd_mobile_app/widgets/searchBar.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = AuthRepository();
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  IList<Product> allProducts = IList();

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
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: kUnActiveColor,
              currentIndex: _bottomBarIndex,
              fixedColor: kSecondaryColor,
              onTap: (value) async {
                switch (value) {
                  case 0:
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.clear();
                    Navigator.popAndPushNamed(context, ProfilePage.id);
                    break;
                  case 1:
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.clear();
                    await _auth.signOut();
                    Navigator.popAndPushNamed(context, loginPage.id);
                    break;
                  case 2:
                    // Perform actions for the third option
                    break;
                }

                setState(
                  () {
                    _bottomBarIndex = value;
                  },
                );
              },
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: ('Test'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.close),
                  label: ('signout'.tr()),
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: ('Test'),
                ),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
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
            body: TabBarView(
              children: [
                //NOTE: Changed the products view to the actual categories.
                //TODO: MUST remove nuts view and use productsView.
                nutsView(),
                ProductsView(Category.spices, allProducts),
                ProductsView(Category.oils, allProducts),
                ProductsView(Category.grains, allProducts),
                ProductsView(Category.other, allProducts),
              ],
            ),
          ),
        ),
        // const SearchBarApp(),
        const CustomeDiscoverbar(),
      ],
    );
  }

  //NOTE: Changed To Other Stream.
  Widget nutsView() {
    return StreamBuilder<IList<Product>>(
      stream: repositoryClient.productRepository.getAllProducts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data); // Print the data to see its structure

          allProducts = snapshot.data;

          var products =
              allProducts.where((element) => element.category == Category.nuts);
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
            ),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductInfo.id,
                      arguments: products.elementAt(index));
                },
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.network(
                        products.elementAt(index).imageLink,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: .6,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //TODO: Add localization
                                Text(
                                  products.elementAt(index).productNameEN,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                //TODO: Select which price to view.
                                Text(products
                                    .elementAt(index)
                                    .retailPrice
                                    .toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            itemCount: products.length,
          );
        } else {
          return const Center(child: (Text('Loading...........')));
        }
      },
    );
  }
}
