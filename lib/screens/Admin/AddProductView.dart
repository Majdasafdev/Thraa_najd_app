import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/models/Category.dart';
import 'package:thraa_najd_mobile_app/models/ExcelProductDTO.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_text_field.dart';
import '../../utils/constants.dart';

class AddProductView extends StatefulWidget {
  static const String id = "AddProductView";

  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String productNameAR = "";
  String productNameEN = "";
  String imageLink = "";
  String materialId = "";
  String costPrice = "";
  Category category = Category.nuts;

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
                CustomTextField(
                  hintText: "Material ID",
                  onChanged: (data) {
                    materialId = data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: "Product name English",
                  onChanged: (data) {
                    productNameEN = data;
                  },
                ),
                const SizedBox(
                  height: 10,
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
                  hintText: "Product price",
                  onChanged: (data) {
                    costPrice = data;
                  },
                ),
                DropdownButton(
                  hint: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Product Category")),
                  isExpanded: true,
                  underline: Container(),
                  alignment: Alignment.bottomCenter,
                  elevation: 0,
                  borderRadius: BorderRadius.circular(10),
                  value: category,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  isDense: true,
                  menuMaxHeight: MediaQuery.sizeOf(context).height * 0.4,
                  padding: const EdgeInsets.all(10),
                  items: [
                    DropdownMenuItem(
                        value: Category.nuts,
                        child: Text(Category.nuts.name.tr())),
                    DropdownMenuItem(
                        value: Category.oils,
                        child: Text(Category.oils.name.tr())),
                    DropdownMenuItem(
                        value: Category.grains,
                        child: Text(Category.grains.name.tr())),
                    DropdownMenuItem(
                        value: Category.spices,
                        child: Text(Category.spices.name.tr())),
                    DropdownMenuItem(
                        value: Category.other,
                        child: Text(Category.other.name.tr())),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        category = value;
                      });
                    }
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

                        var result = await repositoryClient.productRepository
                            .addProduct(
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
                        if (result && context.mounted) {
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        print('Error While Adding Product: $e');
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
