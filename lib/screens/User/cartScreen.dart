// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thraa_najd_mobile_app/constants.dart';
import 'package:thraa_najd_mobile_app/models/product.dart';
import 'package:thraa_najd_mobile_app/providers/cartItem.dart';

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
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        elevation: 0,
        title: Text(
          'My Cart',
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
      body: Expanded(
        child: Container(
          height: 50,
          width: 70,
          color: Colors.red,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                height: screenHeight * .8,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: screenHeight * .15 / 2,
                      backgroundImage: AssetImage(products[index].pLocation),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Text(
                                products[index].pName,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '\$ ${products[index].pPrice}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                color: kMainColor,
              );
            },
            itemCount: products.length,
          ),
        ),
      ),
    );
  }
}
