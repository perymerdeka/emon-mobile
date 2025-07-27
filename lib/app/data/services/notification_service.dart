import 'package:dio/dio.dart';
import '../../core/http_client.dart';
import '../../core/api_config.dart';
import '../../core/api_response.dart';
import '../models/notification_model.dart';

class NotificationService {
  final HttpClient _httpClient = HttpClient();

  // Get all notifications with optional filtering
  Future<ApiResponse<List<Notification>>> getNotifications([
    NotificationFilter? filter,
  ]) async {
    try {
      final queryParams = filter?.toQueryParameters();
      final response = await _httpClient.get(
        ApiConfig.notifications,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final notifications = data
            .map((json) => Notification.fromJson(json))
            .toList();

        return ApiResponse<List<Notification>>(
          success: true,
          data: notifications,
        );
      } else {
        return ApiResponse<List<Notification>>(
          success: false,
          message: 'Failed to get notifications',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<List<Notification>>(e);
    } catch (e) {
      return ApiResponse<List<Notification>>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Mark notification as read
  Future<ApiResponse<void>> markAsRead(int id) async {
    try {
      final response = await _httpClient.put(
        '${ApiConfig.notifications}/$id/read',
      );

      if (response.statusCode == 200) {
        return ApiResponse<void>(
          success: true,
          message: 'Notification marked as read',
        );
      } else {
        return ApiResponse<void>(
          success: false,
          message: 'Failed to mark notification as read',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<void>(e);
    } catch (e) {
      return ApiResponse<void>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Mark all notifications as read
  Future<ApiResponse<void>> markAllAsRead() async {
    try {
      final response = await _httpClient.put(
        '${ApiConfig.notifications}/read-all',
      );

      if (response.statusCode == 200) {
        return ApiResponse<void>(
          success: true,
          message: 'All notifications marked as read',
        );
      } else {
        return ApiResponse<void>(
          success: false,
          message: 'Failed to mark all notifications as read',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<void>(e);
    } catch (e) {
      return ApiResponse<void>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get unread notifications
  Future<ApiResponse<List<Notification>>> getUnreadNotifications() async {
    try {
      final filter = NotificationFilter(isRead: false);
      return await getNotifications(filter);
    } catch (e) {
      return ApiResponse<List<Notification>>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get notifications by type
  Future<ApiResponse<List<Notification>>> getNotificationsByType(
    NotificationType type,
  ) async {
    try {
      final filter = NotificationFilter(type: type);
      return await getNotifications(filter);
    } catch (e) {
      return ApiResponse<List<Notification>>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get recent notifications
  Future<ApiResponse<List<Notification>>> getRecentNotifications([
    int limit = 10,
  ]) async {
    try {
      final filter = NotificationFilter(size: limit);
      return await getNotifications(filter);
    } catch (e) {
      return ApiResponse<List<Notification>>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get notification count
  Future<ApiResponse<int>> getNotificationCount([bool? isRead]) async {
    try {
      final filter = NotificationFilter(isRead: isRead);
      final response = await getNotifications(filter);

      if (response.success && response.data != null) {
        return ApiResponse<int>(success: true, data: response.data!.length);
      } else {
        return ApiResponse<int>(
          success: false,
          message: 'Failed to get notification count',
        );
      }
    } catch (e) {
      return ApiResponse<int>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get unread notification count
  Future<ApiResponse<int>> getUnreadNotificationCount() async {
    return await getNotificationCount(false);
  }

  // Handle Dio errors
  ApiResponse<T> _handleDioError<T>(DioException e) {
    String message = 'Network error';

    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final data = e.response!.data;

      switch (statusCode) {
        case 400:
          message = data['detail'] ?? 'Bad request';
          break;
        case 401:
          message = 'Unauthorized - Please login again';
          break;
        case 403:
          message = 'Forbidden - Access denied';
          break;
        case 404:
          message = 'Notification not found';
          break;
        case 422:
          message = 'Validation error';
          break;
        case 500:
          message = 'Server error';
          break;
        default:
          message = data['detail'] ?? 'Unknown error';
      }
    } else if (e.type == DioExceptionType.connectionTimeout) {
      message = 'Connection timeout';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      message = 'Receive timeout';
    } else if (e.type == DioExceptionType.connectionError) {
      message = 'No internet connection';
    }

    return ApiResponse<T>(success: false, message: message);
  }
}
