import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:thraa_najd_mobile_app/services/AuthRepository.dart';
import 'package:thraa_najd_mobile_app/services/ProductRepository.dart';

abstract class AbstractRepository {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
}

class RepositoryClient {
  final ProductRepository productRepository = ProductRepository();
  final AuthRepository authRepository = AuthRepository();
}
