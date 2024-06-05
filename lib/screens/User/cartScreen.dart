import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thraa_najd_mobile_app/constants.dart';
import 'package:thraa_najd_mobile_app/models/product.dart';
import 'package:thraa_najd_mobile_app/providers/cartItem.dart';
import 'package:thraa_najd_mobile_app/screens/User/product_info.dart';
import 'package:thraa_najd_mobile_app/services/store.dart';

import '../../widgets/cusotme_menu.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static String id = 'CartScreen';

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
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
          style: const TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
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
                return SizedBox(
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
                          child: Column(
                            children: [
                              Container(
                                color: kSecondaryColor,
                                height: screenHeight * .15,
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
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  products[index].pName,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  products[index].pPrice,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Text(
                                              products[index]
                                                  .pQuantity
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                    ),
                                  ),
                                  child: Text(
                                    "confirmOrder".tr(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: products.length,
                  ),
                );
              } else {
                return SizedBox(
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
          child: const Text('Edit'),
        ),
        MyPopupMenuItem(
          onClick: () {
            Navigator.pop(context);
            Provider.of<CartItem>(context, listen: false)
                .deleteProduct(product);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }

  void showCustomDialog(List<Product> products, BuildContext context) async {
    double price = getTotallPrice(products);
    String? address;
    String? nameOfClient;
    String? mobileNumClinet;

    AlertDialog alertDialog = AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            if (address != null &&
                nameOfClient != null &&
                mobileNumClinet != null) {
              try {
                Store store = Store();
                store.storeOrders({
                  kTotallPrice: price,
                  kAddress: address!,
                  kNameOfClient: nameOfClient!,
                  kMobileNumClinet: mobileNumClinet!,
                }, products);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order Placed Successfully'),
                  ),
                );
                Navigator.of(context).pop();
              } catch (ex) {
                print('Error: $ex');
              }
            }
          },
          child: const Text('Confirm'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                address = value;
              },
              decoration: const InputDecoration(hintText: 'Enter your Address'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                nameOfClient = value;
              },
              decoration: const InputDecoration(hintText: 'Enter your Name'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                mobileNumClinet = value;
              },
              decoration:
                  const InputDecoration(hintText: 'Enter your Phone number'),
            ),
          ],
        ),
      ),
      title: Text('Total Price = \$${price.toStringAsFixed(2)}'),
    );

    await showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }

  getTotallPrice(List<Product> products) {
    double price = 0;
    for (var product in products) {
      price += product.pQuantity! * int.parse(product.pPrice);
    }
    return price;
  }
}
