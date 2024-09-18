import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/models/Category.dart';
import 'package:thraa_najd_mobile_app/models/Product.dart';
import 'package:thraa_najd_mobile_app/utils/Extensions.dart';
import 'package:thraa_najd_mobile_app/screens/User/ProductInfo.dart';

class ProductsView extends StatefulWidget {
  final Category category;
  final IList<Product> allProducts;

  const ProductsView(
      {super.key, required this.category, required this.allProducts});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final IList<Product> products = widget.allProducts.where((element) {
      var query = true;
      if (queryController.value.text.isNotEmpty) {
        query = (element.productNameEN
                .toLowerCase()
                .contains(queryController.value.text.toLowerCase()) ||
            element.productNameAR
                .toLowerCase()
                .contains(queryController.value.text.toLowerCase()));
      }
      return query;
    }).toIList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              onChanged: (value) => setState(() {}),
              controller: queryController,
              decoration: InputDecoration(
                  hintText: 'search'.tr(), labelText: 'search'.tr())),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (context, index) => LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: constraints.maxHeight),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ProductInfo.id,
                            arguments: products[index]);
                      },
                      child: Column(
                        children: <Widget>[
                          //NOTE: changed image from assets to the cloud image
                          SizedBox(
                            height: constraints.maxHeight *
                                0.5, // adjust the height ratio as needed
                            child: Image.network(
                              products.elementAt(index).imageLink,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Opacity(
                            opacity: .6,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: constraints.maxHeight *
                                  0.4, // adjust the height ratio as needed
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
                                        context.locale
                                            .getProductName(products[index]),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Flexible(
                                        child: Text(
                                            'SAR ${products.elementAt(index).getProductPrice(context)} ')),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            itemCount: products.length,
          ),
        )
      ],
    );
  }
}
