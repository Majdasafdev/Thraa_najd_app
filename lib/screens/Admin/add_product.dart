import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/models/Category.dart';
import 'package:thraa_najd_mobile_app/models/ExcelProductDTO.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_text_field.dart';
import '../../utils/constants.dart';

class AddProduct extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  //NOTE: Changed the fields.
  late String productNameAR,
      productNameEN,
      imageLink,
      productDescription,
      materialId = "";
  late String costPrice = "";
  late Category category = Category.nuts;

  static String id = 'AddProduct';

  AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //NOTE: added arabic, english fields, added material ID.
                CustomTextField(
                  hintText: "Material ID",
                  onChanged: (data) {
                    materialId = data;
                  },
                ),
                CustomTextField(
                  hintText: "Product name English",
                  onChanged: (data) {
                    productNameEN = data;
                  },
                ),
                CustomTextField(
                  hintText: "Product name Arabic",
                  onChanged: (data) {
                    productNameAR = data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: "Product Image URL",
                  onChanged: (data) {
                    imageLink = data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: "Product description",
                  onChanged: (data) {
                    productDescription = data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: "Product category",
                  onChanged: (data) {
                    // TODO: Add category.
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: "Product price",
                  onChanged: (data) {
                    costPrice = data;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                //NOTE: Changed the flow of product addition.
                ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      formkey.currentState!.reset();

                      try {
                        double? parsedCost = double.tryParse(costPrice);
                        if (parsedCost == null) {
                          throw Exception("Incorrect price");
                        }

                        repositoryClient.productRepository.addProduct(
                            productDTO: ExcelProductDTO(
                                productId: "",
                                materialId: materialId,
                                productNameEN: productNameEN,
                                productNameAR: productNameAR,
                                category: category,
                                costPrice: parsedCost,
                                retailPrice:
                                    ExcelProductDTO.calcRetail(parsedCost),
                                wholesalePrice:
                                    ExcelProductDTO.calcWholesalePrice(
                                        parsedCost),
                                imageLink: null,
                                stocked: true),
                            rawImageLink: imageLink);
                      } catch (e) {
                        // Handle the error here
                        print('Error adding product: $e');
                        // Show a snackbar or some UI feedback to the user
                      }
                    }
                  },
                  child: const Text('Add Product'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
