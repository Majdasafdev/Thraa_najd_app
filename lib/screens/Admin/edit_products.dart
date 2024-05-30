import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/models/oldProduct.dart';
import 'package:thraa_najd_mobile_app/services/store.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_text_field.dart';

class EditProducts extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late String _name = '';
  late String _price = '';
  late String _description = '';
  late String _category = '';
  late String _imageLocation = '';

  static String id = 'AddProduct';
  final _store = Store();

  EditProducts({super.key});
  @override
  Widget build(BuildContext context) {
    OldProduct? product =
        ModalRoute.of(context)!.settings.arguments as OldProduct?;
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
                CustomTextField(
                  hintText: "Product name",
                  onChanged: (data) {
                    _name = data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: "Product location",
                  onChanged: (data) {
                    _imageLocation = data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: "Product description",
                  onChanged: (data) {
                    _description = data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: "Product category",
                  onChanged: (data) {
                    _category = data;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: "Product price",
                  onChanged: (data) {
                    _price = data;
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
                      _store.editProduct({
                        kProductName: _name,
                        kProductLocation: _imageLocation,
                        kProductCategory: _category,
                        kProductDescription: _description,
                        kProductPrice: _price,
                      }, product?.pId);
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
