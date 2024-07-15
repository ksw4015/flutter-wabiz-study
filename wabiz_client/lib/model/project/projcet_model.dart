import 'package:freezed_annotation/freezed_annotation.dart';

part 'projcet_model.g.dart';
part 'projcet_model.freezed.dart';

@freezed
class ProjectModel with _$ProjectModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ProjectModel({
    @Default([]) List<ProjectItemModel> projects
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json)
  => _$ProjectModelFromJson(json);
}

@freezed
class ProjectItemModel with _$ProjectItemModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ProjectItemModel({
    int? id,
    int? categoryId,
    int? projectTypeId,
    String? userId,
    String? title,
    String? owner,
    int? price,
    String? thumbnail,
    String? deadline,
    String? description,
    String? projectClass,
    int? waitlistCount,
    int? totalFundedCount,
    int? totalFunded,
    String? isOpen,
    String? category,
    String? type,
    @Default([]) List<int> image,
    @Default([]) List<int> projectImage
  }) = _ProjectItemModel;

  factory ProjectItemModel.fromJson(Map<String, dynamic> json)
  => _$ProjectItemModelFromJson(json);
}
