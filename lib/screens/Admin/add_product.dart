import 'package:flutter/material.dart';
import 'package:thraa_najd_mobile_app/models/product.dart';
import 'package:thraa_najd_mobile_app/services/store.dart';
import 'package:thraa_najd_mobile_app/widgets/custome_text_field.dart';
import '../../constants.dart';

class AddProduct extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late String _name, _price, _description, _category, _imageLocation;

  static String id = 'AddProduct';
  final _store = Store();

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

                      try {
                        _store.addProduct(
                          Product(
                            pName: _name,
                            pPrice: _price,
                            pDescription: _description,
                            pLocation: _imageLocation,
                            pCategory: _category,
                          ),
                        );
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
