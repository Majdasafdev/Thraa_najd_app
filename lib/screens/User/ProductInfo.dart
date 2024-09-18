import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thraa_najd_mobile_app/models/CartItem.dart';
import 'package:thraa_najd_mobile_app/models/Product.dart';
import 'package:thraa_najd_mobile_app/utils/Extensions.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/providers/CartNotifier.dart';
import 'package:thraa_najd_mobile_app/screens/User/CartView.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';

  const ProductInfo({super.key});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    //NOTE: NEVER use as operator;
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Image.network(
              product.imageLink,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                screenWidth * 0.05, screenHeight * 0.05, screenWidth * 0.05, 0),
            child: Container(
              color: Colors.transparent,
              height: screenHeight * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: screenWidth * 0.08,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      color: kSecondaryColor,
                      size: screenWidth * 0.08,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Opacity(
                    opacity: .5,
                    child: Container(
                      color: Colors.white,
                      width: screenWidth,
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.locale.getProductName(product),
                              style: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              product.getProductPrice(context).toString(),
                              style: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              "${"isStocked".tr()}: ${product.isStocked}",
                              style: TextStyle(
                                  fontSize: screenWidth * 0.06,
                                  fontWeight: FontWeight.bold,
                                  color: kSecondaryColor),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Material(
                                    color: kMainColor,
                                    child: GestureDetector(
                                      onTap: add,
                                      child: SizedBox(
                                        height: screenWidth * 0.08,
                                        width: screenWidth * 0.08,
                                        child: Icon(Icons.add,
                                            size: screenWidth * 0.06),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.05),
                                Text(
                                  _quantity.toString(),
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.08),
                                ),
                                SizedBox(width: screenWidth * 0.05),
                                ClipOval(
                                  child: Material(
                                    color: kMainColor,
                                    child: GestureDetector(
                                      onTap: subtract,
                                      child: SizedBox(
                                        height: screenWidth * 0.08,
                                        width: screenWidth * 0.08,
                                        child: Icon(Icons.remove,
                                            size: screenWidth * 0.06),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: screenWidth * 0.8,
                    child: Builder(
                      builder: (context) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kMainColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            addToCart(context, product);
                          },
                          child: Text(
                            'Add to Cart'.toUpperCase(),
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //NOTE: Changed the flow here.
  void addToCart(context, Product product) {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);
    bool exist = false;
    var productsInCart = cartNotifier.cartItems;
    for (var productInCart in productsInCart) {
      if (productInCart.product.materialId == product.materialId) {
        exist = true;
      }
    }
    if (exist) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('you\'ve added this item before'),
        ),
      );
    } else {
      cartNotifier.addCartItem(CartItem(product: product, quantity: _quantity));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added to Cart'),
        ),
      );
    }
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        print(_quantity);
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
      print(_quantity);
    });
  }
}
