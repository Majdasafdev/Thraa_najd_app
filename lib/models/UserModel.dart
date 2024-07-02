import 'package:dart_mappable/dart_mappable.dart';

part 'UserModel.mapper.dart';

@MappableClass()
class UserModel with UserModelMappable {
  final String email;
  final String name;
  final String? phoneNumber;
  final String? address;

  const UserModel(
      {required this.email,
      required this.name,
      this.phoneNumber,
      this.address});

  static const fromMap = UserModelMapper.fromMap;

  static String get firebaseName => "name";
}
