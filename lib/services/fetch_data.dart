import 'package:excel/excel.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thraa_najd_mobile_app/models/product.dart';

Future<void> readExcelFile(String filePath) async {
  var file = 'assets/Data/ThraaProducts.json';
  var bytes = File(file).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  for (var table in excel.tables.keys) {
    print(table); //sheet Name
    print(excel.tables[table]!.maxRows);
    print(excel.tables[table]!.rows);

    for (var row in excel.tables[table]!.rows) {
      print('$row');
    }
  }
}

Future<void> uploadData(List<Product> data) async {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('your-collection');

  for (var entry in data) {
    await collection.add(entry.toJson());
  }
}
