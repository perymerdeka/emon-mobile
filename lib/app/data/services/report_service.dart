import 'package:dio/dio.dart';
import '../../core/http_client.dart';
import '../../core/api_config.dart';
import '../../core/api_response.dart';
import '../models/report_model.dart';

class ReportService {
  final HttpClient _httpClient = HttpClient();

  // Get monthly report
  Future<ApiResponse<MonthlyReport>> getMonthlyReport(
    int month,
    int year,
  ) async {
    try {
      final response = await _httpClient.get(
        ApiConfig.reportsMonthly,
        queryParameters: {'month': month, 'year': year},
      );

      if (response.statusCode == 200) {
        final report = MonthlyReport.fromJson(response.data);
        return ApiResponse<MonthlyReport>(success: true, data: report);
      } else {
        return ApiResponse<MonthlyReport>(
          success: false,
          message: 'Failed to get monthly report',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<MonthlyReport>(e);
    } catch (e) {
      return ApiResponse<MonthlyReport>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get yearly report
  Future<ApiResponse<YearlyReport>> getYearlyReport(int year) async {
    try {
      final response = await _httpClient.get(
        ApiConfig.reportsYearly,
        queryParameters: {'year': year},
      );

      if (response.statusCode == 200) {
        final report = YearlyReport.fromJson(response.data);
        return ApiResponse<YearlyReport>(success: true, data: report);
      } else {
        return ApiResponse<YearlyReport>(
          success: false,
          message: 'Failed to get yearly report',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<YearlyReport>(e);
    } catch (e) {
      return ApiResponse<YearlyReport>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get custom date range report
  Future<ApiResponse<ReportSummary>> getCustomReport(
    CustomReportRequest request,
  ) async {
    try {
      final response = await _httpClient.get(
        ApiConfig.reportsCustom,
        queryParameters: request.toJson(),
      );

      if (response.statusCode == 200) {
        final report = ReportSummary.fromJson(response.data);
        return ApiResponse<ReportSummary>(success: true, data: report);
      } else {
        return ApiResponse<ReportSummary>(
          success: false,
          message: 'Failed to get custom report',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<ReportSummary>(e);
    } catch (e) {
      return ApiResponse<ReportSummary>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get current month report
  Future<ApiResponse<MonthlyReport>> getCurrentMonthReport() async {
    try {
      final now = DateTime.now();
      return await getMonthlyReport(now.month, now.year);
    } catch (e) {
      return ApiResponse<MonthlyReport>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get current year report
  Future<ApiResponse<YearlyReport>> getCurrentYearReport() async {
    try {
      final now = DateTime.now();
      return await getYearlyReport(now.year);
    } catch (e) {
      return ApiResponse<YearlyReport>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get last 30 days report
  Future<ApiResponse<ReportSummary>> getLast30DaysReport() async {
    try {
      final endDate = DateTime.now();
      final startDate = endDate.subtract(Duration(days: 30));

      final request = CustomReportRequest(
        startDate: startDate,
        endDate: endDate,
      );

      return await getCustomReport(request);
    } catch (e) {
      return ApiResponse<ReportSummary>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get last 7 days report
  Future<ApiResponse<ReportSummary>> getLast7DaysReport() async {
    try {
      final endDate = DateTime.now();
      final startDate = endDate.subtract(Duration(days: 7));

      final request = CustomReportRequest(
        startDate: startDate,
        endDate: endDate,
      );

      return await getCustomReport(request);
    } catch (e) {
      return ApiResponse<ReportSummary>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get report by category
  Future<ApiResponse<ReportSummary>> getReportByCategory(
    DateTime startDate,
    DateTime endDate,
    int categoryId,
  ) async {
    try {
      final request = CustomReportRequest(
        startDate: startDate,
        endDate: endDate,
        categoryId: categoryId,
      );

      return await getCustomReport(request);
    } catch (e) {
      return ApiResponse<ReportSummary>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
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
          message = 'Report not found';
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
