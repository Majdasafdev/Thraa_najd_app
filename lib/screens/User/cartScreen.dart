import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/models/oldProduct.dart';
import 'package:thraa_najd_mobile_app/providers/cartItem.dart';
import 'package:thraa_najd_mobile_app/screens/User/product_info.dart';
import 'package:thraa_najd_mobile_app/services/store.dart';

import '../../widgets/cusotme_menu.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static String id = 'CartScreen';

  @override
  Widget build(BuildContext context) {
    List<OldProduct> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0,
        title: Text(
          'myCart'.tr(),
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (products.isNotEmpty) {
                return Container(
                  height: screenHeight -
                      statusBarHeight -
                      appBarHeight -
                      (screenHeight * .08),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTapUp: (details) {
                            showCustomMenu(details, context, products[index]);
                          },
                          child: Container(
                            color: kSecondaryColor,
                            height: screenHeight * .15,
                            // width: screenWidth * .8,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: screenHeight * .15 / 2,
                                  backgroundImage:
                                      AssetImage(products[index].pLocation),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              products[index].pName,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              products[index].pPrice,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          products[index].pQuantity.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      ButtonTheme(
                                        minWidth: screenWidth,
                                        height: screenHeight * .08,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            showCustomDialog(products, context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10)),
                                            ),
                                          ),
                                          child: Text(
                                            "confirmOrder".tr(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: products.length,
                  ),
                );
              } else {
                return Container(
                  height: screenHeight -
                      (screenHeight * .08) -
                      appBarHeight -
                      statusBarHeight,
                  child: Center(
                    child: Text("emptyCart".tr()),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void showCustomMenu(details, context, product) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
      items: [
        MyPopupMenuItem(
          onClick: () {
            Navigator.pop(context);
            Provider.of<CartItem>(context, listen: false)
                .deleteProduct(product);
            Navigator.pushNamed(context, ProductInfo.id, arguments: product);
          },
          child: Text('Edit'),
        ),
        MyPopupMenuItem(
          onClick: () {
            Navigator.pop(context);
            Provider.of<CartItem>(context, listen: false)
                .deleteProduct(product);
          },
          child: Text('Delete'),
        ),
      ],
    );
  }

  void showCustomDialog(List<OldProduct> products, context) async {
    var price = getTotallPrice(products);
    var address;
    var nameOfClient;
    var mobileNumClinet;
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            try {
              Store _store = Store();
              _store.storeOrders({
                kTotallPrice: price,
                kAddress: address,
                kNameOfClient: nameOfClient,
                kMobileNumClinet: mobileNumClinet
              }, products);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Orderd Successfully'),
              ));
              Navigator.pop(context);
            } catch (ex) {
              print(ex);
            }
          },
          child: Text('Confirm'),
        )
      ],
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                address = value;
              },
              decoration: InputDecoration(hintText: 'Enter your Address'),
            ),
            TextField(
              onChanged: (value) {
                nameOfClient = value;
              },
              decoration: InputDecoration(hintText: 'Enter your Name'),
            ),
            TextField(
              onChanged: (value) {
                mobileNumClinet = value;
              },
              decoration: InputDecoration(hintText: 'Enter your Phone number'),
            ),
          ],
        ),
      ),
      title: Text('Totall Price  =  $price'),
    );
    await showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  getTotallPrice(List<OldProduct> products) {
    var price = 0;
    for (var product in products) {
      price += product.pQuantity! * int.parse(product.pPrice);
    }
    return price;
  }
}
