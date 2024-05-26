import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thraa_najd_mobile_app/constants.dart';
import 'package:thraa_najd_mobile_app/function.dart';
import 'package:thraa_najd_mobile_app/models/product.dart';
import 'package:thraa_najd_mobile_app/screens/User/product_info.dart';
import 'package:thraa_najd_mobile_app/screens/User/profileUserScreen.dart';
import 'package:thraa_najd_mobile_app/screens/login_screen.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_discover.dart';
import 'package:thraa_najd_mobile_app/widgets/product_view.dart';
import 'package:thraa_najd_mobile_app/services/auth.dart';
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
  final _auth = Auth();
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = Store();
  List<Product> _products = [];

  Future<void> _loadProductsFromJsonAndUploadToFirestore() async {
    try {
      String jsonString = await DefaultAssetBundle.of(context).loadString(
          'assets/Data/ThraaProducts.json'); // Assuming your JSON file is in the 'assets' folder
      List<dynamic> jsonData = json.decode(jsonString);

      List<Product> productsjson = [];
      for (var item in jsonData) {
        productsjson.add(Product.fromJson(item));
      }

      // Upload products to Firestore
      await _uploadProductsToFirestore(productsjson);

      setState(() {
        _products = productsjson;
      });
    } catch (e) {
      print('Error loading products from JSON and uploading to Firestore: $e');
    }
  }

  Future<void> _uploadProductsToFirestore(List<Product> productsJson) async {
    final CollectionReference productCollection =
        FirebaseFirestore.instance.collection(kArProductsCollection);

    for (var product in productsJson) {
      await productCollection.add(product.toJson());
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProductsFromJsonAndUploadToFirestore();
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
                      color: _tabBarIndex == 3 ? kMainColor : kSecondaryColor,
                      fontSize: _tabBarIndex == 3 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                nutsView(),
                //ProductsView(kNuts, _products),
                ProductsView(kSpices, _products),
                ProductsView(kOils, _products),
                ProductsView(kGrain, _products),
                ProductsView(kOthers, _products),
              ],
            ),
          ),
        ),
        // const SearchBarApp(),
        const CustomeDiscoverbar(),
      ],
    );
  }

  Widget nutsView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data); // Print the data to see its structure
          List<Product> products = [];
          for (var doc in snapshot.data.docs) {
            var data = doc.data() as Map<String, dynamic>;
            print(data);
            products.add(
              Product(
                pId: doc.id,
                pPrice: data[kProductPrice].toString(),
                pName: data[kProductName].toString(),
                pDescription: data[kProductDescription].toString(),
                pLocation: data[kProductLocation].toString(),
                pCategory: data[kProductCategory].toString(),
                //   arPname: data[kProductarName].toString(),
              ),
            );
          }
          _products = [...products]; //Screed opreator
          products.clear();
          products = getProductByCategory(kNuts, _products);
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
                      arguments: products[index]);
                },
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(products[index].pLocation),
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
                                Text(
                                  products[index].pName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(products[index].pPrice),
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
