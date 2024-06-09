// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'Category.dart';

class CategoryMapper extends EnumMapper<Category> {
  CategoryMapper._();

  static CategoryMapper? _instance;
  static CategoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CategoryMapper._());
    }
    return _instance!;
  }

  static Category fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Category decode(dynamic value) {
    switch (value) {
      case 'nuts':
        return Category.nuts;
      case 'spices':
        return Category.spices;
      case 'oils':
        return Category.oils;
      case 'grains':
        return Category.grains;
      case 'other':
        return Category.other;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Category self) {
    switch (self) {
      case Category.nuts:
        return 'nuts';
      case Category.spices:
        return 'spices';
      case Category.oils:
        return 'oils';
      case Category.grains:
        return 'grains';
      case Category.other:
        return 'other';
    }
  }
}

extension CategoryMapperExtension on Category {
  String toValue() {
    CategoryMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Category>(this) as String;
  }
}
