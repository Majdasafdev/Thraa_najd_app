// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'ProductDTO.dart';

class ProductDTOMapper extends ClassMapperBase<ProductDTO> {
  ProductDTOMapper._();

  static ProductDTOMapper? _instance;
  static ProductDTOMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductDTOMapper._());
      CategoryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProductDTO';

  static String _$productId(ProductDTO v) => v.productId;
  static const Field<ProductDTO, String> _f$productId =
      Field('productId', _$productId);
  static String _$materialId(ProductDTO v) => v.materialId;
  static const Field<ProductDTO, String> _f$materialId =
      Field('materialId', _$materialId);
  static String _$productNameEN(ProductDTO v) => v.productNameEN;
  static const Field<ProductDTO, String> _f$productNameEN =
      Field('productNameEN', _$productNameEN);
  static String _$productNameAR(ProductDTO v) => v.productNameAR;
  static const Field<ProductDTO, String> _f$productNameAR =
      Field('productNameAR', _$productNameAR);
  static Category? _$category(ProductDTO v) => v.category;
  static const Field<ProductDTO, Category> _f$category =
      Field('category', _$category);
  static double _$costPrice(ProductDTO v) => v.costPrice;
  static const Field<ProductDTO, double> _f$costPrice =
      Field('costPrice', _$costPrice);
  static double _$retailPrice(ProductDTO v) => v.retailPrice;
  static const Field<ProductDTO, double> _f$retailPrice =
      Field('retailPrice', _$retailPrice);
  static double _$wholesalePrice(ProductDTO v) => v.wholesalePrice;
  static const Field<ProductDTO, double> _f$wholesalePrice =
      Field('wholesalePrice', _$wholesalePrice);
  static Uint8List? _$imageLink(ProductDTO v) => v.imageLink;
  static const Field<ProductDTO, Uint8List> _f$imageLink =
      Field('imageLink', _$imageLink);
  static bool _$stocked(ProductDTO v) => v.stocked;
  static const Field<ProductDTO, bool> _f$stocked = Field('stocked', _$stocked);

  @override
  final MappableFields<ProductDTO> fields = const {
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

  static ProductDTO _instantiate(DecodingData data) {
    return ProductDTO(
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

  static ProductDTO fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductDTO>(map);
  }

  static ProductDTO fromJson(String json) {
    return ensureInitialized().decodeJson<ProductDTO>(json);
  }
}

mixin ProductDTOMappable {
  String toJson() {
    return ProductDTOMapper.ensureInitialized()
        .encodeJson<ProductDTO>(this as ProductDTO);
  }

  Map<String, dynamic> toMap() {
    return ProductDTOMapper.ensureInitialized()
        .encodeMap<ProductDTO>(this as ProductDTO);
  }

  ProductDTOCopyWith<ProductDTO, ProductDTO, ProductDTO> get copyWith =>
      _ProductDTOCopyWithImpl(this as ProductDTO, $identity, $identity);
  @override
  String toString() {
    return ProductDTOMapper.ensureInitialized()
        .stringifyValue(this as ProductDTO);
  }

  @override
  bool operator ==(Object other) {
    return ProductDTOMapper.ensureInitialized()
        .equalsValue(this as ProductDTO, other);
  }

  @override
  int get hashCode {
    return ProductDTOMapper.ensureInitialized().hashValue(this as ProductDTO);
  }
}

extension ProductDTOValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductDTO, $Out> {
  ProductDTOCopyWith<$R, ProductDTO, $Out> get $asProductDTO =>
      $base.as((v, t, t2) => _ProductDTOCopyWithImpl(v, t, t2));
}

abstract class ProductDTOCopyWith<$R, $In extends ProductDTO, $Out>
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
      Uint8List? imageLink,
      bool? stocked});
  ProductDTOCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProductDTOCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductDTO, $Out>
    implements ProductDTOCopyWith<$R, ProductDTO, $Out> {
  _ProductDTOCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductDTO> $mapper =
      ProductDTOMapper.ensureInitialized();
  @override
  $R call(
          {String? productId,
          String? materialId,
          String? productNameEN,
          String? productNameAR,
          Object? category = $none,
          double? costPrice,
          double? retailPrice,
          double? wholesalePrice,
          Object? imageLink = $none,
          bool? stocked}) =>
      $apply(FieldCopyWithData({
        if (productId != null) #productId: productId,
        if (materialId != null) #materialId: materialId,
        if (productNameEN != null) #productNameEN: productNameEN,
        if (productNameAR != null) #productNameAR: productNameAR,
        if (category != $none) #category: category,
        if (costPrice != null) #costPrice: costPrice,
        if (retailPrice != null) #retailPrice: retailPrice,
        if (wholesalePrice != null) #wholesalePrice: wholesalePrice,
        if (imageLink != $none) #imageLink: imageLink,
        if (stocked != null) #stocked: stocked
      }));
  @override
  ProductDTO $make(CopyWithData data) => ProductDTO(
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
  ProductDTOCopyWith<$R2, ProductDTO, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProductDTOCopyWithImpl($value, $cast, t);
}
