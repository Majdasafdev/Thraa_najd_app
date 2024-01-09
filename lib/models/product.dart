class Product {
  String pName;
  String? pPrice;
  String pLocation;
  String? pDescription;
  String? pCategory;
  String? pId;
  int? pQuantity;
  Product(
      {this.pQuantity,
      this.pId,
      required this.pName,
      this.pCategory,
      this.pDescription,
      required this.pLocation,
      this.pPrice});
}
/*{required this.pQuantity,
      required this.pId,
      required this.pName,
      required this.pCategory,
      required this.pDescription,
      required this.pLocation,
      required this.pPrice}
      
      
      
      
      
      
      
      
       String pName;
  String? pPrice;
  String pLocation;
  String? pDescription;
  String? pCategory;
  String pId;
  int? pQuantity;
  Product(
      {this.pQuantity,
      required this.pId,
      required this.pName,
      this.pCategory,
      this.pDescription,
      required this.pLocation,
      this.pPrice});
      
      
      
      
      
      
      **/