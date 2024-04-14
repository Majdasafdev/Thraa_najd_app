class Product {
  String pName;
  String? arPname;
  String? arPrice;
  String pPrice;
  String pLocation;
  String? arPdescription;
  String pDescription;
  String? arPcategory;
  String? pCategory;
  String? pId;
  int? arPquantity;
  int? pQuantity;

  Product({
    this.arPdescription,
    this.arPcategory,
    this.arPrice,
    this.arPquantity,
    this.pQuantity,
    this.pId,
    this.arPname,
    required this.pName,
    this.pCategory,
    required this.pDescription,
    required this.pLocation,
    required this.pPrice,
  });

  // Define toJson method to convert Product to a Map
  Map<String, dynamic> toJson() {
    return {
      'pId': pId,
      'pQuantity': pQuantity,
      'pName': pName,
      'pCategory': pCategory,
      'pDescription': pDescription,
      'pLocation': pLocation,
      'pPrice': pPrice,
      'arPname': arPname,
      'arPrice': arPrice,
      'arPdescription': arPdescription,
      'arPcategory': arPcategory,
      'arPquantity': arPquantity,
    };
  }

  // Define fromJson factory method to create a Product instance from a Map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      pId: json['pId'],
      pQuantity: json['pQuantity'] ?? 0,
      pName: json['pName'] ?? '',
      pCategory: json['pCategory'] ?? '',
      pDescription: json['pDescription'] ?? '',
      pLocation: json['pLocation'] ?? '',
      pPrice: json['pPrice'] == null ? '0' : json['pPrice'].toString(),
      arPname: json['arPname'],
      arPrice: json['arPrice'],
      arPdescription: json['arPdescription'],
      arPcategory: json['arPcategory'],
      arPquantity: json['arPquantity'] ?? 0,
    );
  }
}
