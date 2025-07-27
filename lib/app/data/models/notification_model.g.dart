// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
  id: (json['id'] as num?)?.toInt(),
  message: json['message'] as String,
  type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
  isRead: json['is_read'] as bool? ?? false,
  userId: (json['user_id'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'is_read': instance.isRead,
      'user_id': instance.userId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.recurringTxGenerated: 'recurring_tx_generated',
  NotificationType.budgetExceeded: 'budget_exceeded',
  NotificationType.billDue: 'bill_due',
  NotificationType.goalAchieved: 'goal_achieved',
  NotificationType.system: 'system',
};

NotificationFilter _$NotificationFilterFromJson(Map<String, dynamic> json) =>
    NotificationFilter(
      isRead: json['isRead'] as bool?,
      type: $enumDecodeNullable(_$NotificationTypeEnumMap, json['type']),
      page: (json['page'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NotificationFilterToJson(NotificationFilter instance) =>
    <String, dynamic>{
      'isRead': instance.isRead,
      'type': _$NotificationTypeEnumMap[instance.type],
      'page': instance.page,
      'size': instance.size,
    };
