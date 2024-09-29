import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/models/ExcelProductDTO.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/widgets/snack_bar.dart';

import '../../models/Category.dart';
import '../../models/Product.dart';

class EditProductView extends StatefulWidget {
  static const id = "EditProductView";
  final Product product;

  const EditProductView({super.key, required this.product});

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController productNameAR = TextEditingController();
  TextEditingController productNameEN = TextEditingController();
  TextEditingController imageLink = TextEditingController();
  TextEditingController materialId = TextEditingController();
  TextEditingController costPrice = TextEditingController();
  TextEditingController retailUnitAR = TextEditingController();
  TextEditingController retailUnitEN = TextEditingController();
  TextEditingController wholesaleUnitAR = TextEditingController();
  TextEditingController wholesaleUnitEN = TextEditingController();
  bool stocked = false;
  Category category = Category.nuts;

  @override
  void initState() {
    super.initState();
    Future(
      () {
        setState(() {
          productNameAR.text = widget.product.productNameAR;
          productNameEN.text = widget.product.productNameEN;
          imageLink.text = widget.product.imageLink;
          materialId.text = widget.product.materialId;
          costPrice.text = widget.product.costPrice.toString();
          category = widget.product.category;
          retailUnitAR.text = widget.product.retailPrice.unitAR;
          retailUnitEN.text = widget.product.retailPrice.unitAR;
          wholesaleUnitAR.text = widget.product.wholesalePrice.unitAR;
          wholesaleUnitEN.text = widget.product.wholesalePrice.unitEN;
          stocked = widget.product.stocked;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: materialId,
                      decoration:
                          const InputDecoration(hintText: "Material Id"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: productNameEN,
                      decoration: const InputDecoration(
                          hintText: "Product Name English"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: productNameAR,
                      decoration: const InputDecoration(
                          hintText: "Product Name Arabic"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: imageLink,
                      decoration:
                          const InputDecoration(hintText: "Product Image URL"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: costPrice,
                      decoration:
                          const InputDecoration(hintText: "Product Cost Price"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: retailUnitAR,
                      decoration: InputDecoration(
                        hintText: "product-RetailUnitAR".tr(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: retailUnitEN,
                      decoration: InputDecoration(
                        hintText: "product-RetailUnitEN".tr(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: wholesaleUnitAR,
                      decoration: InputDecoration(
                        hintText: "product-WholeSaleUnitAR".tr(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: wholesaleUnitEN,
                      decoration: InputDecoration(
                        hintText: "product-WholeSaleUnitEN".tr(),
                      ),
                    ),
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
                  CheckboxListTile(
                      value: stocked,
                      onChanged: (value) {
                        setState(() {
                          stocked = value!;
                        });
                      },
                      title: const Text("is Stocked")),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        if (formkey.currentState!.validate()) {
                          formkey.currentState!.save();
                          formkey.currentState!.reset();
                          double? parsedCost =
                              double.tryParse(costPrice.value.text);
                          if (parsedCost == null) {
                            throw Exception("Incorrect price");
                          }
                          var result = await repositoryClient.productRepository
                              .updateProduct(Product(
                                  productId: widget.product.productId,
                                  materialId: materialId.value.text,
                                  productNameEN: productNameEN.value.text,
                                  productNameAR: productNameAR.value.text,
                                  category: category,
                                  costPrice: parsedCost,
                                  retailPrice: ProductPrice.calcRetail(
                                      costPrice: parsedCost,
                                      unitEN: retailUnitEN.value.text,
                                      unitAR: retailUnitAR.value.text),
                                  wholesalePrice:
                                      ProductPrice.calcWholesalePrice(
                                          costPrice: parsedCost,
                                          unitAR: wholesaleUnitAR.value.text,
                                          unitEN: wholesaleUnitEN.value.text),
                                  imageLink: imageLink.value.text,
                                  stocked: stocked));
                          if (result && context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      } catch (e, stk) {
                        if (context.mounted) {
                          showSnackBar(context, e.toString());
                        }
                      }
                    },
                    child: const Text('Edit Product'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
