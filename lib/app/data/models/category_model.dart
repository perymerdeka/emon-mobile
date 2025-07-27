import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

enum CategoryType {
  @JsonValue('income')
  income,
  @JsonValue('expense')
  expense,
}

@JsonSerializable()
class Category {
  final int? id;
  final String name;
  final String description;
  final CategoryType type;
  final String color;
  final String icon;
  @JsonKey(name: 'owner_id')
  final int? ownerId;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  Category({
    this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.color,
    required this.icon,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  Category copyWith({
    int? id,
    String? name,
    String? description,
    CategoryType? type,
    String? color,
    String? icon,
    int? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

@JsonSerializable()
class CategoryCreateRequest {
  final String name;
  final String description;
  final CategoryType type;
  final String color;
  final String icon;

  CategoryCreateRequest({
    required this.name,
    required this.description,
    required this.type,
    required this.color,
    required this.icon,
  });

  factory CategoryCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$CategoryCreateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryCreateRequestToJson(this);
}

@JsonSerializable()
class CategoryUpdateRequest {
  final String? name;
  final String? description;
  final CategoryType? type;
  final String? color;
  final String? icon;

  CategoryUpdateRequest({
    this.name,
    this.description,
    this.type,
    this.color,
    this.icon,
  });

  factory CategoryUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$CategoryUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryUpdateRequestToJson(this);
}
