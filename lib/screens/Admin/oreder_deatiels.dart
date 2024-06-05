import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/models/Order.dart';
import 'package:thraa_najd_mobile_app/models/Product.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/models/oldProduct.dart';
import 'package:thraa_najd_mobile_app/services/store.dart';

import '../../models/CustomerOrder.dart';

class OrderDeatiels extends StatelessWidget {
  static String id = 'OrderDeatiels';

  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      //NOTE: Changed from query snapshot to Customer Order.
      body: StreamBuilder<CustomerOrder>(
          stream: repositoryClient.ordersRepository.getOrderById(documentId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var order = snapshot.data!;

              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          color: kSecondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //TODO: Add Localization
                                Text(
                                    'product name : ${order.products.elementAt(index).product.productNameEN}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Quantity : ${order.products.elementAt(index).quantity}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //TODO: Add Localization.
                                Text(
                                  'product Category : ${order.products.elementAt(index).product.category.nameEN}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //TODO: Retails or wholesale?
                                Text(
                                  'Product price : ${order.products.elementAt(index).product.retailPrice}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: order.products.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: kMainColor,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Confirm Order'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: kMainColor,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Delete Order'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Loading Order Details'),
              );
            }
          }),
    );
  }
}
