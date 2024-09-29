import 'package:dart_mappable/dart_mappable.dart';
import 'package:thraa_najd_mobile_app/models/Product.dart';

part 'CartItem.mapper.dart';

@MappableClass()
class CartItem with CartItemMappable {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  double get totalRetailPrice => quantity * product.retailPrice.price;

  double get totalWholeSale => quantity * product.wholesalePrice.price;

  static double getListTotalPrice(List<CartItem> items, bool isWholesale) {
    return items.fold(
        0,
        (previousValue, element) =>
            previousValue +
            (isWholesale ? element.totalWholeSale : element.totalRetailPrice));
  }
}
