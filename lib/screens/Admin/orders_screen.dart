// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/services/store.dart';

//import 'package:flutter/cupertino.dart';
import '../../models/CustomerOrder.dart';
import '../../models/Order.dart';
import 'oreder_deatiels.dart';

// ignore: depend_on_referenced_packages
import 'package:thraa_najd_mobile_app/models/order.dart' as reusable;

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  static String id = 'OrdersScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //NOTE: Used the new load orders here.
      body: StreamBuilder<List<CustomerOrder>>(
        stream: repositoryClient.ordersRepository.loadOrders(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('there is no orders'),
            );
          }
          if ((snapshot.data as List<CustomerOrder>).isEmpty) {
            return const Center(
              child: Text('there is no orders'),
            );
          }
          List<CustomerOrder> orders = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDeatiels.id,
                      arguments: orders[index].orderId);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  color: kSecondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Totall Price = ${orders[index].totalPrice}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Address is ${orders[index].address}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),

                        //TODO: Why display documentId??
                        Text(
                          'Id order: ${orders[index].orderId}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            itemCount: orders.length,
          );
        },
      ),
    );
  }
}
