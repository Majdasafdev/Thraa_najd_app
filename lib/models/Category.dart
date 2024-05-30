import 'package:dart_mappable/dart_mappable.dart';

part 'Category.mapper.dart';

@MappableEnum()
enum Category {
  nuts(nameAR: "مكسرات", nameEN: "Nuts"),
  spices(nameAR: "بهارات", nameEN: "Spices"),
  oils(nameAR: "زيوت", nameEN: "Oils"),
  grains(nameEN: "Grains", nameAR: "حبوب"),
  other(nameEN: "Other", nameAR: "غير ذلك");

  const Category({required this.nameAR, required this.nameEN});

  final String nameEN;
  final String nameAR;
}
