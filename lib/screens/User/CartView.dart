import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thraa_najd_mobile_app/models/CartItem.dart';
import 'package:thraa_najd_mobile_app/providers/CartNotifier.dart';
import 'package:thraa_najd_mobile_app/providers/SectionNotifier.dart';
import 'package:thraa_najd_mobile_app/screens/User/ProductInfo.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/Extensions.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_logo.dart';

import '../../models/CustomerOrder.dart';
import '../../widgets/cusotme_menu.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static String id = 'CartScreen';

  @override
  Widget build(BuildContext context) {
    List<CartItem> currentCartItems =
        Provider.of<CartNotifier>(context).cartItems;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: kUnActiveColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        elevation: 0,
        title: Text(
          'myCart'.tr(),
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
      body: currentCartItems.isNotEmpty
          ? Column(children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTapUp: (details) {
                        showCustomMenu(
                            details, context, currentCartItems[index]);
                      },
                      child: Container(
                        color: kSecondaryColor,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: screenHeight * .15 / 2,
                              //NOTE: Changed The Image
                              backgroundImage: NetworkImage(
                                  currentCartItems[index].product.imageLink),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.locale.getProductName(
                                        currentCartItems[index].product),
                                    maxLines: 4,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "total Price: ${currentCartItems[index].product.getProductPrice(context)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      "Quantity: ${currentCartItems[index].quantity.toString()}",
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
                    ),
                  );
                },
                itemCount: currentCartItems.length,
              ),
              ButtonTheme(
                minWidth: screenWidth,
                height: screenHeight * .08,
                child: ElevatedButton(
                  onPressed: () {
                    showCustomDialog(currentCartItems, context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondaryColor,
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
              CustomLogo()
            ])
          : SizedBox(
              height: screenHeight -
                  (screenHeight * .08) -
                  appBarHeight -
                  statusBarHeight,
              child: Center(
                child: Text("emptyCart".tr()),
              ),
            ),
    );
  }

  void showCustomMenu(details, context, CartItem product) async {
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
            Provider.of<CartNotifier>(context, listen: false)
                .deleteCartItem(product);
            //NOTE: Passed product here.
            Navigator.pushNamed(context, ProductInfo.id,
                arguments: product.product);
          },
          child: const Text('Edit'),
        ),
        MyPopupMenuItem(
          onClick: () {
            Navigator.pop(context);
            Provider.of<CartNotifier>(context, listen: false)
                .deleteCartItem(product);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }

  //NOTE: Edited workflow.
  //TODO: Assign actual address, clientName, clientNumber.
  void showCustomDialog(List<CartItem> cartItems, context) async {
    //TODO: HOT FIX: Must FIX price fetching mechanism!!
    var price =
        -1.0; //CartItem.getListTotalPrice(cartItems, Provider.of<SectionNotifier>(context).isWholeSale);
    String address = "";
    String clientName = "";
    String clientNumber = "";
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            try {
              repositoryClient.ordersRepository.storeOrders(CustomerOrder(
                  totalPrice: price,
                  clientName: clientName,
                  clientMobileNumber: clientNumber,
                  address: address,
                  products: cartItems,
                  orderId: "",
                  orderStatus: false,
                  isWholesale:
                      Provider.of<SectionNotifier>(context).isWholeSale));

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Orderd Successfully'),
              ));
              //      Provider.of<CartNotifier>(context, listen: false)
              ////          .clearCart(); // Add this line
              //      Navigator.pop(context);
            } catch (ex) {
              print(ex);
            }
          },
          child: const Text('Confirm'),
        )
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
            TextField(
              onChanged: (value) {
                clientName = value;
              },
              decoration: const InputDecoration(hintText: 'Enter your Name'),
            ),
            TextField(
              onChanged: (value) {
                clientNumber = value;
              },
              decoration:
                  const InputDecoration(hintText: 'Enter your Phone number'),
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
}
