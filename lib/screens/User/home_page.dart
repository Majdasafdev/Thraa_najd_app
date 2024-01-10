import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thraa_najd_mobile_app/constants.dart';
import 'package:thraa_najd_mobile_app/models/product.dart';
import 'package:thraa_najd_mobile_app/screens/Admin/admin_home.dart';
import 'package:thraa_najd_mobile_app/screens/login_screen.dart';
import 'package:thraa_najd_mobile_app/widgets/nuts_view.dart';
import 'package:thraa_najd_mobile_app/widgets/product_view.dart';
import 'package:thraa_najd_mobile_app/services/auth.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  late List<Product> _products;
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
                if (value == 2) {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.clear();
                  await _auth.signOut();
                  Navigator.popAndPushNamed(context, loginPage.id);
                }
                setState(
                  () {
                    _bottomBarIndex = value;
                  },
                );
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: ('Test'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: ('Test'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.close),
                  label: ('Sign Out'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: ('Test'),
                ),
                BottomNavigationBarItem(
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
                    'Nuts',
                    style: TextStyle(
                      color: _tabBarIndex == 0 ? kMainColor : kSecondaryColor,
                      fontSize: _tabBarIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Spices',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? kMainColor : kSecondaryColor,
                      fontSize: _tabBarIndex == 1 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Oils',
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? kMainColor : kSecondaryColor,
                      fontSize: _tabBarIndex == 2 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Grain',
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? kMainColor : kSecondaryColor,
                      fontSize: _tabBarIndex == 3 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Else',
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
                ProductsView(kSpices, _products),
                ProductsView(kOils, _products),
                ProductsView(kGrain, _products),
                ProductsView(kOthers, _products),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover Thraa Najd Store'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AdminHome.id);
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      color: kSecondaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
