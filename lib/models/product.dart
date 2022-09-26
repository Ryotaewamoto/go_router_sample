import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

// モデル定義
@freezed
class Product with _$Product {
  const factory Product({
    required String productId,
    required FaIcon faIcon,
  }) = _Product;

  // factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
