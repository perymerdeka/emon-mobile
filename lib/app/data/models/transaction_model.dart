import 'package:json_annotation/json_annotation.dart';
import 'category_model.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class Transaction {
  final int? id;
  final double amount;
  final CategoryType type;
  final DateTime date;
  final String? description;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'owner_id')
  final int? ownerId;

  // Relationships
  final Category? category;

  Transaction({
    this.id,
    required this.amount,
    required this.type,
    required this.date,
    this.description,
    this.createdAt,
    this.updatedAt,
    required this.categoryId,
    this.ownerId,
    this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  Transaction copyWith({
    int? id,
    double? amount,
    CategoryType? type,
    DateTime? date,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? categoryId,
    int? ownerId,
    Category? category,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryId: categoryId ?? this.categoryId,
      ownerId: ownerId ?? this.ownerId,
      category: category ?? this.category,
    );
  }
}

@JsonSerializable()
class TransactionCreateRequest {
  final double amount;
  final DateTime date;
  final String? description;
  @JsonKey(name: 'category_id')
  final int categoryId;

  TransactionCreateRequest({
    required this.amount,
    required this.date,
    this.description,
    required this.categoryId,
  });

  factory TransactionCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$TransactionCreateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionCreateRequestToJson(this);
}

@JsonSerializable()
class TransactionUpdateRequest {
  final double? amount;
  final DateTime? date;
  final String? description;
  @JsonKey(name: 'category_id')
  final int? categoryId;

  TransactionUpdateRequest({
    this.amount,
    this.date,
    this.description,
    this.categoryId,
  });

  factory TransactionUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$TransactionUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionUpdateRequestToJson(this);
}

@JsonSerializable()
class TransactionFilter {
  final DateTime? startDate;
  final DateTime? endDate;
  final int? categoryId;
  final CategoryType? type;
  final int? page;
  final int? size;

  TransactionFilter({
    this.startDate,
    this.endDate,
    this.categoryId,
    this.type,
    this.page,
    this.size,
  });

  factory TransactionFilter.fromJson(Map<String, dynamic> json) =>
      _$TransactionFilterFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionFilterToJson(this);

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};

    if (startDate != null) {
      params['start_date'] = startDate!.toIso8601String().split('T')[0];
    }
    if (endDate != null) {
      params['end_date'] = endDate!.toIso8601String().split('T')[0];
    }
    if (categoryId != null) {
      params['category_id'] = categoryId;
    }
    if (type != null) {
      params['type'] = type!.name;
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
