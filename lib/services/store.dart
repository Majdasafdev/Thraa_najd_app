import 'package:thraa_najd_mobile_app/utils/constants.dart';
import 'package:thraa_najd_mobile_app/models/oldProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addProduct(OldProduct product) {
    _firestore.collection(kProductsCollection).add(
      {
        // kProductarName: product.arPname,
        kProductName: product.pName,
        kProductDescription: product.pDescription,
        kProductLocation: product.pLocation,
        kProductCategory: product.pCategory,
        kProductPrice: product.pPrice,
      },
    );
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kProductsCollection).snapshots();
//  return DatabaseReference;
  }

  final CollectionReference productCollection = FirebaseFirestore.instance
      .collection(
          kArProductsCollection); // or 'Products' based on your database

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore
        .collection(kOrders)
        .doc(documentId)
        .collection(kOrderDetails)
        .snapshots();
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(kOrders).snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(kProductsCollection).doc(documentId).delete();
  }

  editProduct(
    data,
    documentId,
  ) {
    _firestore.collection(kProductsCollection).doc(documentId).update(data);
  }

  storeOrders(data, List<OldProduct> products) {
    var documentRef = _firestore.collection(kOrders).doc();
    documentRef.set(data);
    for (var product in products) {
      documentRef.collection(kOrderDetails).doc().set(
        {
          kProductName: product.pName,
          kProductPrice: product.pPrice,
          kProductQuantity: product.pQuantity,
          kProductLocation: product.pLocation,
          kProductCategory: product.pCategory
        },
      );
    }
  }
}
