// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RewardItemModelImpl _$$RewardItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RewardItemModelImpl(
      id: (json['id'] as num?)?.toInt(),
      projectId: (json['projectId'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toInt(),
      description: json['description'] as String?,
      imageRaw: (json['imageRaw'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RewardItemModelImplToJson(
        _$RewardItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'imageRaw': instance.imageRaw,
    };
