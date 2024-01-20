class Order {
  String documentId;
  int totallPrice;
  String address;
  Order(
      {required int this.totallPrice,
      required this.address,
      required this.documentId});
}
