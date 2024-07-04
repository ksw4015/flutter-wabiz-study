import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.g.dart';
part 'category.freezed.dart';

@freezed
class Category with _$Category {
  const factory Category({
    int? id,
    String? category,
    String? title,
    String? iconPath,
    String? created
}) = _Category;

  factory Category.fromJson(Map<String, dynamic> json)
    => _$CategoryFromJson(json);
}