import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

enum NotificationType {
  @JsonValue('recurring_tx_generated')
  recurringTxGenerated,
  @JsonValue('budget_exceeded')
  budgetExceeded,
  @JsonValue('bill_due')
  billDue,
  @JsonValue('goal_achieved')
  goalAchieved,
  @JsonValue('system')
  system,
}

@JsonSerializable()
class Notification {
  final int? id;
  final String message;
  final NotificationType type;
  @JsonKey(name: 'is_read')
  final bool isRead;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  Notification({
    this.id,
    required this.message,
    required this.type,
    this.isRead = false,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  Notification copyWith({
    int? id,
    String? message,
    NotificationType? type,
    bool? isRead,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Notification(
      id: id ?? this.id,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

@JsonSerializable()
class NotificationFilter {
  final bool? isRead;
  final NotificationType? type;
  final int? page;
  final int? size;

  NotificationFilter({this.isRead, this.type, this.page, this.size});

  factory NotificationFilter.fromJson(Map<String, dynamic> json) =>
      _$NotificationFilterFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationFilterToJson(this);

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};

    if (isRead != null) {
      params['is_read'] = isRead;
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
