// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryDtoImpl _$$CategoryDtoImplFromJson(Map<String, dynamic> json) =>
    _$CategoryDtoImpl(
      status: json['status'] as String?,
      totalCount: (json['total_count'] as num?)?.toInt(),
      projects: (json['projects'] as List<dynamic>?)
              ?.map(
                  (e) => CategoryItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CategoryDtoImplToJson(_$CategoryDtoImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'total_count': instance.totalCount,
      'projects': instance.projects,
    };
