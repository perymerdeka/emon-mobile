import 'package:dio/dio.dart';
import '../../core/http_client.dart';
import '../../core/api_config.dart';
import '../../core/api_response.dart';
import '../models/budget_model.dart';

class BudgetService {
  final HttpClient _httpClient = HttpClient();

  // Get all budgets with optional filtering
  Future<ApiResponse<List<Budget>>> getBudgets([BudgetFilter? filter]) async {
    try {
      final queryParams = filter?.toQueryParameters();
      final response = await _httpClient.get(
        ApiConfig.budgets,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final budgets = data.map((json) => Budget.fromJson(json)).toList();

        return ApiResponse<List<Budget>>(success: true, data: budgets);
      } else {
        return ApiResponse<List<Budget>>(
          success: false,
          message: 'Failed to get budgets',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<List<Budget>>(e);
    } catch (e) {
      return ApiResponse<List<Budget>>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get budget by ID
  Future<ApiResponse<Budget>> getBudget(int id) async {
    try {
      final response = await _httpClient.get('${ApiConfig.budgets}/$id');

      if (response.statusCode == 200) {
        final budget = Budget.fromJson(response.data);
        return ApiResponse<Budget>(success: true, data: budget);
      } else {
        return ApiResponse<Budget>(
          success: false,
          message: 'Failed to get budget',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<Budget>(e);
    } catch (e) {
      return ApiResponse<Budget>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Create new budget
  Future<ApiResponse<Budget>> createBudget(BudgetCreateRequest request) async {
    try {
      final response = await _httpClient.post(
        ApiConfig.budgets,
        data: request.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final budget = Budget.fromJson(response.data);
        return ApiResponse<Budget>(
          success: true,
          data: budget,
          message: 'Budget created successfully',
        );
      } else {
        return ApiResponse<Budget>(
          success: false,
          message: 'Failed to create budget',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<Budget>(e);
    } catch (e) {
      return ApiResponse<Budget>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Update budget
  Future<ApiResponse<Budget>> updateBudget(
    int id,
    BudgetUpdateRequest request,
  ) async {
    try {
      final response = await _httpClient.put(
        '${ApiConfig.budgets}/$id',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final budget = Budget.fromJson(response.data);
        return ApiResponse<Budget>(
          success: true,
          data: budget,
          message: 'Budget updated successfully',
        );
      } else {
        return ApiResponse<Budget>(
          success: false,
          message: 'Failed to update budget',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<Budget>(e);
    } catch (e) {
      return ApiResponse<Budget>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Delete budget
  Future<ApiResponse<void>> deleteBudget(int id) async {
    try {
      final response = await _httpClient.delete('${ApiConfig.budgets}/$id');

      if (response.statusCode == 204 || response.statusCode == 200) {
        return ApiResponse<void>(
          success: true,
          message: 'Budget deleted successfully',
        );
      } else {
        return ApiResponse<void>(
          success: false,
          message: 'Failed to delete budget',
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

  // Get current month budget
  Future<ApiResponse<List<Budget>>> getCurrentMonthBudgets() async {
    try {
      final now = DateTime.now();
      final filter = BudgetFilter(month: now.month, year: now.year);

      return await getBudgets(filter);
    } catch (e) {
      return ApiResponse<List<Budget>>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get budget by month and year
  Future<ApiResponse<List<Budget>>> getBudgetsByMonth(
    int month,
    int year,
  ) async {
    try {
      final filter = BudgetFilter(month: month, year: year);

      return await getBudgets(filter);
    } catch (e) {
      return ApiResponse<List<Budget>>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get overall budget (no category)
  Future<ApiResponse<List<Budget>>> getOverallBudgets([
    int? month,
    int? year,
  ]) async {
    try {
      final filter = BudgetFilter(
        month: month,
        year: year,
        categoryId: null, // This will get overall budgets
      );

      return await getBudgets(filter);
    } catch (e) {
      return ApiResponse<List<Budget>>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get category-specific budgets
  Future<ApiResponse<List<Budget>>> getCategoryBudgets(
    int categoryId, [
    int? month,
    int? year,
  ]) async {
    try {
      final filter = BudgetFilter(
        month: month,
        year: year,
        categoryId: categoryId,
      );

      return await getBudgets(filter);
    } catch (e) {
      return ApiResponse<List<Budget>>(
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
          message = 'Budget not found';
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
