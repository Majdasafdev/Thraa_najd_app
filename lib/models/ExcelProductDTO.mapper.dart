// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'ExcelProductDTO.dart';

class ExcelProductDTOMapper extends ClassMapperBase<ExcelProductDTO> {
  ExcelProductDTOMapper._();

  static ExcelProductDTOMapper? _instance;
  static ExcelProductDTOMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ExcelProductDTOMapper._());
      CategoryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ExcelProductDTO';

  static String _$productId(ExcelProductDTO v) => v.productId;
  static const Field<ExcelProductDTO, String> _f$productId =
      Field('productId', _$productId);
  static String _$materialId(ExcelProductDTO v) => v.materialId;
  static const Field<ExcelProductDTO, String> _f$materialId =
      Field('materialId', _$materialId);
  static String _$productNameEN(ExcelProductDTO v) => v.productNameEN;
  static const Field<ExcelProductDTO, String> _f$productNameEN =
      Field('productNameEN', _$productNameEN);
  static String _$productNameAR(ExcelProductDTO v) => v.productNameAR;
  static const Field<ExcelProductDTO, String> _f$productNameAR =
      Field('productNameAR', _$productNameAR);
  static Category? _$category(ExcelProductDTO v) => v.category;
  static const Field<ExcelProductDTO, Category> _f$category =
      Field('category', _$category);
  static double _$costPrice(ExcelProductDTO v) => v.costPrice;
  static const Field<ExcelProductDTO, double> _f$costPrice =
      Field('costPrice', _$costPrice);
  static double _$retailPrice(ExcelProductDTO v) => v.retailPrice;
  static const Field<ExcelProductDTO, double> _f$retailPrice =
      Field('retailPrice', _$retailPrice);
  static double _$wholesalePrice(ExcelProductDTO v) => v.wholesalePrice;
  static const Field<ExcelProductDTO, double> _f$wholesalePrice =
      Field('wholesalePrice', _$wholesalePrice);
  static Uint8List? _$imageLink(ExcelProductDTO v) => v.imageLink;
  static const Field<ExcelProductDTO, Uint8List> _f$imageLink =
      Field('imageLink', _$imageLink);
  static bool _$stocked(ExcelProductDTO v) => v.stocked;
  static const Field<ExcelProductDTO, bool> _f$stocked =
      Field('stocked', _$stocked);

  @override
  final MappableFields<ExcelProductDTO> fields = const {
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

  static ExcelProductDTO _instantiate(DecodingData data) {
    return ExcelProductDTO(
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

  static ExcelProductDTO fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ExcelProductDTO>(map);
  }

  static ExcelProductDTO fromJson(String json) {
    return ensureInitialized().decodeJson<ExcelProductDTO>(json);
  }
}

mixin ExcelProductDTOMappable {
  String toJson() {
    return ExcelProductDTOMapper.ensureInitialized()
        .encodeJson<ExcelProductDTO>(this as ExcelProductDTO);
  }

  Map<String, dynamic> toMap() {
    return ExcelProductDTOMapper.ensureInitialized()
        .encodeMap<ExcelProductDTO>(this as ExcelProductDTO);
  }

  ExcelProductDTOCopyWith<ExcelProductDTO, ExcelProductDTO, ExcelProductDTO>
      get copyWith => _ExcelProductDTOCopyWithImpl(
          this as ExcelProductDTO, $identity, $identity);
  @override
  String toString() {
    return ExcelProductDTOMapper.ensureInitialized()
        .stringifyValue(this as ExcelProductDTO);
  }

  @override
  bool operator ==(Object other) {
    return ExcelProductDTOMapper.ensureInitialized()
        .equalsValue(this as ExcelProductDTO, other);
  }

  @override
  int get hashCode {
    return ExcelProductDTOMapper.ensureInitialized()
        .hashValue(this as ExcelProductDTO);
  }
}

extension ExcelProductDTOValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ExcelProductDTO, $Out> {
  ExcelProductDTOCopyWith<$R, ExcelProductDTO, $Out> get $asExcelProductDTO =>
      $base.as((v, t, t2) => _ExcelProductDTOCopyWithImpl(v, t, t2));
}

abstract class ExcelProductDTOCopyWith<$R, $In extends ExcelProductDTO, $Out>
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
  ExcelProductDTOCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ExcelProductDTOCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ExcelProductDTO, $Out>
    implements ExcelProductDTOCopyWith<$R, ExcelProductDTO, $Out> {
  _ExcelProductDTOCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ExcelProductDTO> $mapper =
      ExcelProductDTOMapper.ensureInitialized();
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
  ExcelProductDTO $make(CopyWithData data) => ExcelProductDTO(
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
  ExcelProductDTOCopyWith<$R2, ExcelProductDTO, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ExcelProductDTOCopyWithImpl($value, $cast, t);
}
