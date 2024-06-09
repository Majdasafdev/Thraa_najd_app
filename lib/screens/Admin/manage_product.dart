import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thraa_najd_mobile_app/screens/Admin/edit_products.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/widgets/cusotme_menu.dart';
import '../../models/Product.dart';
import '../../utils/constants.dart';
import '../../models/oldProduct.dart';
import '../../services/store.dart';

class ManageProducts extends StatelessWidget {
  static String id = 'ManageProducts';

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  ManageProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      //NOTE: Changed from stream builder to future builder.
      //because there is no reason to use streams here.
      body: StreamBuilder(
        stream: repositoryClient.productRepository.getAllProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            IList<Product> products = snapshot.data;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTapUp: (details) async {
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
                            Navigator.pushNamed(context, EditProducts.id,
                                arguments: products[index]);
                          },
                          child: const Text('Edit'),
                        ),
                        MyPopupMenuItem(
                          onClick: () {
                            //NOTE: Here performed Deletion
                            repositoryClient.productRepository
                                .removeProductByProductId(
                                    products.elementAt(index).productId);
                            Navigator.pop(context);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Flexible(
                                    child: Text(
                                        '\$ ${products[index].costPrice}')),
                                //NOTE: added category name
                                //TODO: Integrate localization
                                Flexible(
                                    child: Text(
                                        '\$ ${products[index].category.nameEN}'))
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
          } else {
            return const Center(child: (Text('Loading...........')));
          }
        },
      ),
    );
  }
}
