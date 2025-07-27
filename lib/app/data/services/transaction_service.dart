import 'package:dio/dio.dart';
import '../../core/http_client.dart';
import '../../core/api_config.dart';
import '../../core/api_response.dart';
import '../models/transaction_model.dart';

class TransactionService {
  final HttpClient _httpClient = HttpClient();

  // Get all transactions with optional filtering
  Future<ApiResponse<List<Transaction>>> getTransactions([
    TransactionFilter? filter,
  ]) async {
    try {
      final queryParams = filter?.toQueryParameters();
      final response = await _httpClient.get(
        ApiConfig.transactions,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final transactions = data
            .map((json) => Transaction.fromJson(json))
            .toList();

        return ApiResponse<List<Transaction>>(
          success: true,
          data: transactions,
        );
      } else {
        return ApiResponse<List<Transaction>>(
          success: false,
          message: 'Failed to get transactions',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<List<Transaction>>(e);
    } catch (e) {
      return ApiResponse<List<Transaction>>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get transaction by ID
  Future<ApiResponse<Transaction>> getTransaction(int id) async {
    try {
      final response = await _httpClient.get('${ApiConfig.transactions}/$id');

      if (response.statusCode == 200) {
        final transaction = Transaction.fromJson(response.data);
        return ApiResponse<Transaction>(success: true, data: transaction);
      } else {
        return ApiResponse<Transaction>(
          success: false,
          message: 'Failed to get transaction',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<Transaction>(e);
    } catch (e) {
      return ApiResponse<Transaction>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Create new transaction
  Future<ApiResponse<Transaction>> createTransaction(
    TransactionCreateRequest request,
  ) async {
    try {
      final response = await _httpClient.post(
        ApiConfig.transactions,
        data: request.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final transaction = Transaction.fromJson(response.data);
        return ApiResponse<Transaction>(
          success: true,
          data: transaction,
          message: 'Transaction created successfully',
        );
      } else {
        return ApiResponse<Transaction>(
          success: false,
          message: 'Failed to create transaction',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<Transaction>(e);
    } catch (e) {
      return ApiResponse<Transaction>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Update transaction
  Future<ApiResponse<Transaction>> updateTransaction(
    int id,
    TransactionUpdateRequest request,
  ) async {
    try {
      final response = await _httpClient.put(
        '${ApiConfig.transactions}/$id',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final transaction = Transaction.fromJson(response.data);
        return ApiResponse<Transaction>(
          success: true,
          data: transaction,
          message: 'Transaction updated successfully',
        );
      } else {
        return ApiResponse<Transaction>(
          success: false,
          message: 'Failed to update transaction',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<Transaction>(e);
    } catch (e) {
      return ApiResponse<Transaction>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Delete transaction
  Future<ApiResponse<void>> deleteTransaction(int id) async {
    try {
      final response = await _httpClient.delete(
        '${ApiConfig.transactions}/$id',
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return ApiResponse<void>(
          success: true,
          message: 'Transaction deleted successfully',
        );
      } else {
        return ApiResponse<void>(
          success: false,
          message: 'Failed to delete transaction',
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

  // Get transactions by date range
  Future<ApiResponse<List<Transaction>>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final filter = TransactionFilter(startDate: startDate, endDate: endDate);

      return await getTransactions(filter);
    } catch (e) {
      return ApiResponse<List<Transaction>>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get transactions by category
  Future<ApiResponse<List<Transaction>>> getTransactionsByCategory(
    int categoryId,
  ) async {
    try {
      final filter = TransactionFilter(categoryId: categoryId);
      return await getTransactions(filter);
    } catch (e) {
      return ApiResponse<List<Transaction>>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get recent transactions
  Future<ApiResponse<List<Transaction>>> getRecentTransactions([
    int limit = 10,
  ]) async {
    try {
      final filter = TransactionFilter(size: limit);
      return await getTransactions(filter);
    } catch (e) {
      return ApiResponse<List<Transaction>>(
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
          message = 'Transaction not found';
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
