import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/models/ExcelProductDTO.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_text_field.dart';

import '../../models/Category.dart';
import '../../models/Product.dart';

class EditProducts extends StatelessWidget {
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

  EditProducts({super.key});

  @override
  Widget build(BuildContext context) {
    Product? product = ModalRoute.of(context)!.settings.arguments as Product?;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .130,
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
                    //TODO: Add Category
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: "Product Price",
                  onChanged: (data) {
                    costPrice = data;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      formkey.currentState!.reset();

                      //TODO: Perform edit
                      /*
                      repositoryClient.productRepository.updateProduct(
                          ExcelProductDTO(
                              productId: productId,
                              materialId: materialId,
                              productNameEN: productNameEN,
                              productNameAR: productNameAR,
                              category: category,
                              costPrice: costPrice,
                              retailPrice: retailPrice,
                              wholesalePrice: wholesalePrice,
                              imageLink: imageLink,
                              stocked: stocked));

                       */
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
