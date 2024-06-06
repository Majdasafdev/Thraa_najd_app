import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thraa_najd_mobile_app/models/CartItem.dart';
import 'package:thraa_najd_mobile_app/models/Order.dart';
import 'package:thraa_najd_mobile_app/models/Product.dart';
import 'package:thraa_najd_mobile_app/services/AbstractRepository.dart';
import 'package:thraa_najd_mobile_app/utils/FirebaseConstants.dart';

import '../models/CustomerOrder.dart';
import '../utils/constants.dart';

class OrdersRepository extends AbstractRepository {
  Future<void> addProductToCart(Product product, int customerId) async {}

  Future<void> removeProductFromCart(String cartProductId) async {}

  Stream<List<CustomerOrder>> loadOrders() {
    return firebaseFirestore
        .collection(FirebaseConstants.ordersCollection)
        .snapshots()
        .asyncMap((event) =>
            event.docs.map((e) => CustomerOrder.fromMap(e.data())).toList());
  }

  Future<void> storeOrders(CustomerOrder order) async {
    var orderRef = await firebaseFirestore
        .collection(FirebaseConstants.ordersCollection)
        .add(order.toMap());
    await orderRef.update({CustomerOrder.firebaseOrderId: orderRef.id});
  }

  Stream<CustomerOrder> getOrderById(String orderId) {
    return firebaseFirestore
        .collection(FirebaseConstants.ordersCollection)
        .doc(orderId)
        .snapshots()
        .asyncMap((event) => CustomerOrder.fromMap(event.data()!));
  }
}
