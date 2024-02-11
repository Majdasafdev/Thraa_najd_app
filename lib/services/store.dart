import 'package:firebase_core/firebase_core.dart';
import 'package:thraa_najd_mobile_app/constants.dart';
import 'package:thraa_najd_mobile_app/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addProduct(Product product) {
    _firestore.collection(kProductsCollection).add(
      {
        kProductarName: product.arPname,
        kProductName: product.pName,
        kProductDescription: product.pDescription,
        kProductLocation: product.pLocation,
        kProductCategory: product.pCategory,
        kProductPrice: product.pPrice,
      },
    );
  }

  loadProductsDb() {
    FirebaseDatabase database = FirebaseDatabase.instance;
    // Query dbRef = FirebaseDatabase.instance.ref().child("products");

    final firebaseApp = Firebase.app();
    final rtdb = FirebaseDatabase.instanceFor(
        app: firebaseApp,
        databaseURL: 'https://thraa-najd-app-default-rtdb.firebaseio.com/');
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kProductsCollection).snapshots();
//  return DatabaseReference;
  }

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

  storeOrders(data, List<Product> products) {
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
