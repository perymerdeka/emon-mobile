// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Budget _$BudgetFromJson(Map<String, dynamic> json) => Budget(
  id: (json['id'] as num?)?.toInt(),
  amount: (json['amount'] as num).toDouble(),
  month: (json['month'] as num).toInt(),
  year: (json['year'] as num).toInt(),
  categoryId: (json['category_id'] as num?)?.toInt(),
  ownerId: (json['owner_id'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  category: json['category'] == null
      ? null
      : Category.fromJson(json['category'] as Map<String, dynamic>),
  spent: (json['spent'] as num?)?.toDouble(),
  remaining: (json['remaining'] as num?)?.toDouble(),
  percentage: (json['percentage'] as num?)?.toDouble(),
);

Map<String, dynamic> _$BudgetToJson(Budget instance) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'month': instance.month,
  'year': instance.year,
  'category_id': instance.categoryId,
  'owner_id': instance.ownerId,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'category': instance.category,
  'spent': instance.spent,
  'remaining': instance.remaining,
  'percentage': instance.percentage,
};

BudgetCreateRequest _$BudgetCreateRequestFromJson(Map<String, dynamic> json) =>
    BudgetCreateRequest(
      amount: (json['amount'] as num).toDouble(),
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BudgetCreateRequestToJson(
  BudgetCreateRequest instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'month': instance.month,
  'year': instance.year,
  'category_id': instance.categoryId,
};

BudgetUpdateRequest _$BudgetUpdateRequestFromJson(Map<String, dynamic> json) =>
    BudgetUpdateRequest(
      amount: (json['amount'] as num?)?.toDouble(),
      month: (json['month'] as num?)?.toInt(),
      year: (json['year'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BudgetUpdateRequestToJson(
  BudgetUpdateRequest instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'month': instance.month,
  'year': instance.year,
  'category_id': instance.categoryId,
};

BudgetFilter _$BudgetFilterFromJson(Map<String, dynamic> json) => BudgetFilter(
  month: (json['month'] as num?)?.toInt(),
  year: (json['year'] as num?)?.toInt(),
  categoryId: (json['categoryId'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
  size: (json['size'] as num?)?.toInt(),
);

Map<String, dynamic> _$BudgetFilterToJson(BudgetFilter instance) =>
    <String, dynamic>{
      'month': instance.month,
      'year': instance.year,
      'categoryId': instance.categoryId,
      'page': instance.page,
      'size': instance.size,
    };
