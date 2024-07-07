// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'Product.dart';

class ProductMapper extends ClassMapperBase<Product> {
  ProductMapper._();

  static ProductMapper? _instance;
  static ProductMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductMapper._());
      CategoryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Product';

  static String _$productId(Product v) => v.productId;
  static const Field<Product, String> _f$productId =
      Field('productId', _$productId);
  static String _$materialId(Product v) => v.materialId;
  static const Field<Product, String> _f$materialId =
      Field('materialId', _$materialId);
  static String _$productNameEN(Product v) => v.productNameEN;
  static const Field<Product, String> _f$productNameEN =
      Field('productNameEN', _$productNameEN);
  static String _$productNameAR(Product v) => v.productNameAR;
  static const Field<Product, String> _f$productNameAR =
      Field('productNameAR', _$productNameAR);
  static Category _$category(Product v) => v.category;
  static const Field<Product, Category> _f$category =
      Field('category', _$category);
  static double _$costPrice(Product v) => v.costPrice;
  static const Field<Product, double> _f$costPrice =
      Field('costPrice', _$costPrice);
  static double _$retailPrice(Product v) => v.retailPrice;
  static const Field<Product, double> _f$retailPrice =
      Field('retailPrice', _$retailPrice);
  static double _$wholesalePrice(Product v) => v.wholesalePrice;
  static const Field<Product, double> _f$wholesalePrice =
      Field('wholesalePrice', _$wholesalePrice);
  static String _$imageLink(Product v) => v.imageLink;
  static const Field<Product, String> _f$imageLink =
      Field('imageLink', _$imageLink);
  static bool _$stocked(Product v) => v.stocked;
  static const Field<Product, bool> _f$stocked =
      Field('stocked', _$stocked, opt: true, def: true);

  @override
  final MappableFields<Product> fields = const {
    #productId: _f$productId,
    #materialId: _f$materialId,
    #productNameEN: _f$productNameEN,
    #productNameAR: _f$productNameAR,
    #category: _f$category,
    #costPrice: _f$costPrice,
    #retailPrice: _f$retailPrice,
    #wholesalePrice: _f$wholesalePrice,
    #imageLink: _f$imageLink,
    #stocked: _f$stocked,
  };

  static Product _instantiate(DecodingData data) {
    return Product(
        productId: data.dec(_f$productId),
        materialId: data.dec(_f$materialId),
        productNameEN: data.dec(_f$productNameEN),
        productNameAR: data.dec(_f$productNameAR),
        category: data.dec(_f$category),
        costPrice: data.dec(_f$costPrice),
        retailPrice: data.dec(_f$retailPrice),
        wholesalePrice: data.dec(_f$wholesalePrice),
        imageLink: data.dec(_f$imageLink),
        stocked: data.dec(_f$stocked));
  }

  @override
  final Function instantiate = _instantiate;

  static Product fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Product>(map);
  }

  static Product fromJson(String json) {
    return ensureInitialized().decodeJson<Product>(json);
  }
}

mixin ProductMappable {
  String toJson() {
    return ProductMapper.ensureInitialized()
        .encodeJson<Product>(this as Product);
  }

  Map<String, dynamic> toMap() {
    return ProductMapper.ensureInitialized()
        .encodeMap<Product>(this as Product);
  }

  ProductCopyWith<Product, Product, Product> get copyWith =>
      _ProductCopyWithImpl(this as Product, $identity, $identity);
  @override
  String toString() {
    return ProductMapper.ensureInitialized().stringifyValue(this as Product);
  }

  @override
  bool operator ==(Object other) {
    return ProductMapper.ensureInitialized()
        .equalsValue(this as Product, other);
  }

  @override
  int get hashCode {
    return ProductMapper.ensureInitialized().hashValue(this as Product);
  }
}

extension ProductValueCopy<$R, $Out> on ObjectCopyWith<$R, Product, $Out> {
  ProductCopyWith<$R, Product, $Out> get $asProduct =>
      $base.as((v, t, t2) => _ProductCopyWithImpl(v, t, t2));
}

abstract class ProductCopyWith<$R, $In extends Product, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? productId,
      String? materialId,
      String? productNameEN,
      String? productNameAR,
      Category? category,
      double? costPrice,
      double? retailPrice,
      double? wholesalePrice,
      String? imageLink,
      bool? stocked});
  ProductCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProductCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Product, $Out>
    implements ProductCopyWith<$R, Product, $Out> {
  _ProductCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Product> $mapper =
      ProductMapper.ensureInitialized();
  @override
  $R call(
          {String? productId,
          String? materialId,
          String? productNameEN,
          String? productNameAR,
          Category? category,
          double? costPrice,
          double? retailPrice,
          double? wholesalePrice,
          String? imageLink,
          bool? stocked}) =>
      $apply(FieldCopyWithData({
        if (productId != null) #productId: productId,
        if (materialId != null) #materialId: materialId,
        if (productNameEN != null) #productNameEN: productNameEN,
        if (productNameAR != null) #productNameAR: productNameAR,
        if (category != null) #category: category,
        if (costPrice != null) #costPrice: costPrice,
        if (retailPrice != null) #retailPrice: retailPrice,
        if (wholesalePrice != null) #wholesalePrice: wholesalePrice,
        if (imageLink != null) #imageLink: imageLink,
        if (stocked != null) #stocked: stocked
      }));
  @override
  Product $make(CopyWithData data) => Product(
      productId: data.get(#productId, or: $value.productId),
      materialId: data.get(#materialId, or: $value.materialId),
      productNameEN: data.get(#productNameEN, or: $value.productNameEN),
      productNameAR: data.get(#productNameAR, or: $value.productNameAR),
      category: data.get(#category, or: $value.category),
      costPrice: data.get(#costPrice, or: $value.costPrice),
      retailPrice: data.get(#retailPrice, or: $value.retailPrice),
      wholesalePrice: data.get(#wholesalePrice, or: $value.wholesalePrice),
      imageLink: data.get(#imageLink, or: $value.imageLink),
      stocked: data.get(#stocked, or: $value.stocked));

  @override
  ProductCopyWith<$R2, Product, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProductCopyWithImpl($value, $cast, t);
}
