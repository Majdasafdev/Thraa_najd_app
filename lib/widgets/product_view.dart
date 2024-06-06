import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/models/Category.dart';
import 'package:thraa_najd_mobile_app/models/Product.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/function.dart';
import 'package:thraa_najd_mobile_app/models/oldProduct.dart';
import 'package:thraa_najd_mobile_app/screens/User/product_info.dart';

Widget ProductsView(Category category, IList<Product> allProducts) {
  final IList<Product> products =
      allProducts.where((element) => element.category == category).toIList();

  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: .8,
    ),
    itemBuilder: (context, index) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductInfo.id,
              arguments: products[index]);
        },
        //NOTE: Changed from stack to column
        child: Column(
          children: <Widget>[
            //NOTE: changed image from assets to the cloud image
            SizedBox(
              height: 150,
              child: Image.network(
                products.elementAt(index).imageLink,
                fit: BoxFit.fill,
              ),
            ),
            Opacity(
              opacity: .6,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          //NOTE: Changed here to english product name.
                          //TODO: Integrate localization by if(english) then english name else arabic name.
                          products[index].productNameEN,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(child: Text('\$ ${products[index].costPrice}')),
                      //NOTE: added category name
                      //TODO: Integrate localization
                      Flexible(
                          child: Text('\$ ${products[index].category.nameEN}'))
                    ],
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
}
