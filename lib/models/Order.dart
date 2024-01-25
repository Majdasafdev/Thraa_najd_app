class Order {
  String documentId;
  int totallPrice;
  String address;
  String mobileNumClinet;
  String nameOfClinet;
  Order(
      {required int this.totallPrice,
      required this.nameOfClinet,
      required this.mobileNumClinet,
      required this.address,
      required this.documentId});
}
