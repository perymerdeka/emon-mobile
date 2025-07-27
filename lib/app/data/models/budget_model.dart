import 'package:json_annotation/json_annotation.dart';
import 'category_model.dart';

part 'budget_model.g.dart';

@JsonSerializable()
class Budget {
  final int? id;
  final double amount;
  final int month;
  final int year;
  @JsonKey(name: 'category_id')
  final int? categoryId; // null for overall budget
  @JsonKey(name: 'owner_id')
  final int? ownerId;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  // Relationships
  final Category? category;

  // Computed fields (from backend)
  final double? spent;
  final double? remaining;
  final double? percentage;

  Budget({
    this.id,
    required this.amount,
    required this.month,
    required this.year,
    this.categoryId,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.spent,
    this.remaining,
    this.percentage,
  });

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);
  Map<String, dynamic> toJson() => _$BudgetToJson(this);

  Budget copyWith({
    int? id,
    double? amount,
    int? month,
    int? year,
    int? categoryId,
    int? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Category? category,
    double? spent,
    double? remaining,
    double? percentage,
  }) {
    return Budget(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      month: month ?? this.month,
      year: year ?? this.year,
      categoryId: categoryId ?? this.categoryId,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      spent: spent ?? this.spent,
      remaining: remaining ?? this.remaining,
      percentage: percentage ?? this.percentage,
    );
  }

  // Helper methods
  bool get isOverBudget => spent != null && spent! > amount;
  bool get isNearLimit => spent != null && spent! > (amount * 0.8);
  double get progressPercentage => percentage ?? 0.0;
}

@JsonSerializable()
class BudgetCreateRequest {
  final double amount;
  final int month;
  final int year;
  @JsonKey(name: 'category_id')
  final int? categoryId;

  BudgetCreateRequest({
    required this.amount,
    required this.month,
    required this.year,
    this.categoryId,
  });

  factory BudgetCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$BudgetCreateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BudgetCreateRequestToJson(this);
}

@JsonSerializable()
class BudgetUpdateRequest {
  final double? amount;
  final int? month;
  final int? year;
  @JsonKey(name: 'category_id')
  final int? categoryId;

  BudgetUpdateRequest({this.amount, this.month, this.year, this.categoryId});

  factory BudgetUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$BudgetUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BudgetUpdateRequestToJson(this);
}

@JsonSerializable()
class BudgetFilter {
  final int? month;
  final int? year;
  final int? categoryId;
  final int? page;
  final int? size;

  BudgetFilter({this.month, this.year, this.categoryId, this.page, this.size});

  factory BudgetFilter.fromJson(Map<String, dynamic> json) =>
      _$BudgetFilterFromJson(json);
  Map<String, dynamic> toJson() => _$BudgetFilterToJson(this);

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};

    if (month != null) {
      params['month'] = month;
    }
    if (year != null) {
      params['year'] = year;
    }
    if (categoryId != null) {
      params['category_id'] = categoryId;
    }
    if (page != null) {
      params['page'] = page;
    }
    if (size != null) {
      params['size'] = size;
    }

    return params;
  }
}
