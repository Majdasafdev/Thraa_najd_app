// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/constants.dart';
import 'package:thraa_najd_mobile_app/services/store.dart';
//import 'package:flutter/cupertino.dart';
import 'oreder_deatiels.dart';

// ignore: depend_on_referenced_packages
import 'package:thraa_najd_mobile_app/models/order.dart' as reusable;

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});
  static String id = 'OrdersScreen';
  final Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('there is no orders'),
            );
          } else {
            List<reusable.Order> orders = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              orders.add(
                reusable.Order(
                  documentId: doc.id,
                  address: data[kAddress] as String,
                  totallPrice: data[kTotallPrice] as int,
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OrderDeatiels.id,
                        arguments: orders[index].documentId);
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
                          Text('Totall Price = ${orders[index].totallPrice}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Address is ${orders[index].address}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Id order: ${orders[index].documentId}',
                            style: TextStyle(
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
          }
        },
      ),
    );
  }
}
