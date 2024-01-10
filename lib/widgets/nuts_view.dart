import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/constants.dart';
import 'package:thraa_najd_mobile_app/function.dart';
import 'package:thraa_najd_mobile_app/models/product.dart';
import 'package:thraa_najd_mobile_app/screens/User/product_info.dart';
import 'package:thraa_najd_mobile_app/services/store.dart';

Widget nutsView() {
  final _store = Store();
  late List<Product> _products;
  return StreamBuilder<QuerySnapshot>(
    stream: _store.loadProducts(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        List<Product> products = [];
        for (var doc in snapshot.data.docs) {
          var data = doc.data() as Map<String, dynamic>;
          print(data);
          if (doc[kProductCategory == kNuts])
            products.add(
              Product(
                pId: doc.id,
                pPrice: data[kProductPrice],
                pName: data[kProductName],
                pDescription: data[kProductDescription],
                pLocation: data[kProductLocation],
                pCategory: data[kProductCategory],
              ),
            );
        }
        _products = [...products]; //Screed opreator
        products.clear();
        products = getProductByCategory(kNuts, _products);
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                products[index].pName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('\$ ${products[index].pPrice}')
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
        return Center(child: (Text('Loading...........')));
      }
    },
  );
}
