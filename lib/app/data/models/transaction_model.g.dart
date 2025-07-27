// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  id: (json['id'] as num?)?.toInt(),
  amount: (json['amount'] as num).toDouble(),
  type: $enumDecode(_$CategoryTypeEnumMap, json['type']),
  date: DateTime.parse(json['date'] as String),
  description: json['description'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  categoryId: (json['category_id'] as num).toInt(),
  ownerId: (json['owner_id'] as num?)?.toInt(),
  category: json['category'] == null
      ? null
      : Category.fromJson(json['category'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'type': _$CategoryTypeEnumMap[instance.type]!,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'category_id': instance.categoryId,
      'owner_id': instance.ownerId,
      'category': instance.category,
    };

const _$CategoryTypeEnumMap = {
  CategoryType.income: 'income',
  CategoryType.expense: 'expense',
};

TransactionCreateRequest _$TransactionCreateRequestFromJson(
  Map<String, dynamic> json,
) => TransactionCreateRequest(
  amount: (json['amount'] as num).toDouble(),
  date: DateTime.parse(json['date'] as String),
  description: json['description'] as String?,
  categoryId: (json['category_id'] as num).toInt(),
);

Map<String, dynamic> _$TransactionCreateRequestToJson(
  TransactionCreateRequest instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'date': instance.date.toIso8601String(),
  'description': instance.description,
  'category_id': instance.categoryId,
};

TransactionUpdateRequest _$TransactionUpdateRequestFromJson(
  Map<String, dynamic> json,
) => TransactionUpdateRequest(
  amount: (json['amount'] as num?)?.toDouble(),
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  description: json['description'] as String?,
  categoryId: (json['category_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$TransactionUpdateRequestToJson(
  TransactionUpdateRequest instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'date': instance.date?.toIso8601String(),
  'description': instance.description,
  'category_id': instance.categoryId,
};

TransactionFilter _$TransactionFilterFromJson(Map<String, dynamic> json) =>
    TransactionFilter(
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      categoryId: (json['categoryId'] as num?)?.toInt(),
      type: $enumDecodeNullable(_$CategoryTypeEnumMap, json['type']),
      page: (json['page'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TransactionFilterToJson(TransactionFilter instance) =>
    <String, dynamic>{
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'categoryId': instance.categoryId,
      'type': _$CategoryTypeEnumMap[instance.type],
      'page': instance.page,
      'size': instance.size,
    };
