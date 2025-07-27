// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$CategoryTypeEnumMap, json['type']),
  color: json['color'] as String,
  icon: json['icon'] as String,
  ownerId: (json['owner_id'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'type': _$CategoryTypeEnumMap[instance.type]!,
  'color': instance.color,
  'icon': instance.icon,
  'owner_id': instance.ownerId,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

const _$CategoryTypeEnumMap = {
  CategoryType.income: 'income',
  CategoryType.expense: 'expense',
};

CategoryCreateRequest _$CategoryCreateRequestFromJson(
  Map<String, dynamic> json,
) => CategoryCreateRequest(
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$CategoryTypeEnumMap, json['type']),
  color: json['color'] as String,
  icon: json['icon'] as String,
);

Map<String, dynamic> _$CategoryCreateRequestToJson(
  CategoryCreateRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'type': _$CategoryTypeEnumMap[instance.type]!,
  'color': instance.color,
  'icon': instance.icon,
};

CategoryUpdateRequest _$CategoryUpdateRequestFromJson(
  Map<String, dynamic> json,
) => CategoryUpdateRequest(
  name: json['name'] as String?,
  description: json['description'] as String?,
  type: $enumDecodeNullable(_$CategoryTypeEnumMap, json['type']),
  color: json['color'] as String?,
  icon: json['icon'] as String?,
);

Map<String, dynamic> _$CategoryUpdateRequestToJson(
  CategoryUpdateRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'type': _$CategoryTypeEnumMap[instance.type],
  'color': instance.color,
  'icon': instance.icon,
};
