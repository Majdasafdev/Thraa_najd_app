import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:thraa_najd_mobile_app/models/Product.dart';

part 'CartItem.mapper.dart';

@MappableClass()
class CartItem with CartItemMappable {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  //NOTE: Added total here.
  //TODO: should we use retails price or wholesale price?
  double get totalPrice => quantity * product.retailPrice;

  static double getListTotalPrice(List<CartItem> items) {
    return items.fold(
        0, (previousValue, element) => previousValue + element.totalPrice);
  }
}
