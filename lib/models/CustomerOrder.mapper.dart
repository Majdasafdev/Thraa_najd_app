// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'CustomerOrder.dart';

class CustomerOrderMapper extends ClassMapperBase<CustomerOrder> {
  CustomerOrderMapper._();

  static CustomerOrderMapper? _instance;
  static CustomerOrderMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CustomerOrderMapper._());
      CartItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CustomerOrder';

  static double _$totalPrice(CustomerOrder v) => v.totalPrice;
  static const Field<CustomerOrder, double> _f$totalPrice =
      Field('totalPrice', _$totalPrice);
  static String _$clientName(CustomerOrder v) => v.clientName;
  static const Field<CustomerOrder, String> _f$clientName =
      Field('clientName', _$clientName);
  static String _$clientMobileNumber(CustomerOrder v) => v.clientMobileNumber;
  static const Field<CustomerOrder, String> _f$clientMobileNumber =
      Field('clientMobileNumber', _$clientMobileNumber);
  static String _$address(CustomerOrder v) => v.address;
  static const Field<CustomerOrder, String> _f$address =
      Field('address', _$address);
  static List<CartItem> _$products(CustomerOrder v) => v.products;
  static const Field<CustomerOrder, List<CartItem>> _f$products =
      Field('products', _$products);
  static String _$orderId(CustomerOrder v) => v.orderId;
  static const Field<CustomerOrder, String> _f$orderId =
      Field('orderId', _$orderId);

  @override
  final MappableFields<CustomerOrder> fields = const {
    #totalPrice: _f$totalPrice,
    #clientName: _f$clientName,
    #clientMobileNumber: _f$clientMobileNumber,
    #address: _f$address,
    #products: _f$products,
    #orderId: _f$orderId,
  };

  static CustomerOrder _instantiate(DecodingData data) {
    return CustomerOrder(
        totalPrice: data.dec(_f$totalPrice),
        clientName: data.dec(_f$clientName),
        clientMobileNumber: data.dec(_f$clientMobileNumber),
        address: data.dec(_f$address),
        products: data.dec(_f$products),
        orderId: data.dec(_f$orderId));
  }

  @override
  final Function instantiate = _instantiate;

  static CustomerOrder fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CustomerOrder>(map);
  }

  static CustomerOrder fromJson(String json) {
    return ensureInitialized().decodeJson<CustomerOrder>(json);
  }
}

mixin CustomerOrderMappable {
  String toJson() {
    return CustomerOrderMapper.ensureInitialized()
        .encodeJson<CustomerOrder>(this as CustomerOrder);
  }

  Map<String, dynamic> toMap() {
    return CustomerOrderMapper.ensureInitialized()
        .encodeMap<CustomerOrder>(this as CustomerOrder);
  }

  CustomerOrderCopyWith<CustomerOrder, CustomerOrder, CustomerOrder>
      get copyWith => _CustomerOrderCopyWithImpl(
          this as CustomerOrder, $identity, $identity);
  @override
  String toString() {
    return CustomerOrderMapper.ensureInitialized()
        .stringifyValue(this as CustomerOrder);
  }

  @override
  bool operator ==(Object other) {
    return CustomerOrderMapper.ensureInitialized()
        .equalsValue(this as CustomerOrder, other);
  }

  @override
  int get hashCode {
    return CustomerOrderMapper.ensureInitialized()
        .hashValue(this as CustomerOrder);
  }
}

extension CustomerOrderValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CustomerOrder, $Out> {
  CustomerOrderCopyWith<$R, CustomerOrder, $Out> get $asCustomerOrder =>
      $base.as((v, t, t2) => _CustomerOrderCopyWithImpl(v, t, t2));
}

abstract class CustomerOrderCopyWith<$R, $In extends CustomerOrder, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, CartItem, CartItemCopyWith<$R, CartItem, CartItem>>
      get products;
  $R call(
      {double? totalPrice,
      String? clientName,
      String? clientMobileNumber,
      String? address,
      List<CartItem>? products,
      String? orderId});
  CustomerOrderCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CustomerOrderCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CustomerOrder, $Out>
    implements CustomerOrderCopyWith<$R, CustomerOrder, $Out> {
  _CustomerOrderCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CustomerOrder> $mapper =
      CustomerOrderMapper.ensureInitialized();
  @override
  ListCopyWith<$R, CartItem, CartItemCopyWith<$R, CartItem, CartItem>>
      get products => ListCopyWith($value.products,
          (v, t) => v.copyWith.$chain(t), (v) => call(products: v));
  @override
  $R call(
          {double? totalPrice,
          String? clientName,
          String? clientMobileNumber,
          String? address,
          List<CartItem>? products,
          String? orderId}) =>
      $apply(FieldCopyWithData({
        if (totalPrice != null) #totalPrice: totalPrice,
        if (clientName != null) #clientName: clientName,
        if (clientMobileNumber != null) #clientMobileNumber: clientMobileNumber,
        if (address != null) #address: address,
        if (products != null) #products: products,
        if (orderId != null) #orderId: orderId
      }));
  @override
  CustomerOrder $make(CopyWithData data) => CustomerOrder(
      totalPrice: data.get(#totalPrice, or: $value.totalPrice),
      clientName: data.get(#clientName, or: $value.clientName),
      clientMobileNumber:
          data.get(#clientMobileNumber, or: $value.clientMobileNumber),
      address: data.get(#address, or: $value.address),
      products: data.get(#products, or: $value.products),
      orderId: data.get(#orderId, or: $value.orderId));

  @override
  CustomerOrderCopyWith<$R2, CustomerOrder, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CustomerOrderCopyWithImpl($value, $cast, t);
}
