import 'package:dart_mappable/dart_mappable.dart';
import 'package:thraa_najd_mobile_app/models/CartItem.dart';

part 'CustomerOrder.mapper.dart';

@MappableClass()
class CustomerOrder with CustomerOrderMappable {
  final String orderId;
  final double totalPrice;
  final String address;
  final String clientMobileNumber;
  final String clientName;
  final List<CartItem> products;
  final bool orderStatus;

  const CustomerOrder(
      {required this.totalPrice,
      required this.clientName,
      required this.clientMobileNumber,
      required this.address,
      required this.products,
      required this.orderId,
      required this.orderStatus});

  static const fromMap = CustomerOrderMapper.fromMap;

  static String get firebaseOrderId => "orderId";
  static String get firebaseTotalPrice => "totalPrice";
  static String get firebaseAddress => "address";
  static String get firebaseClientMobileNumber => "clientMobileNumber";
  static String get firebaseClientName => "clientName";
  static String get firebaseProducts => "products";
  static String get firebaseOrderStatus => "orderStatus";
}
