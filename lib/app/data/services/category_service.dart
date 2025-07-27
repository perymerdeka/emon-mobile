import 'package:dio/dio.dart';
import '../../core/http_client.dart';
import '../../core/api_config.dart';
import '../../core/api_response.dart';
import '../models/category_model.dart';

class CategoryService {
  final HttpClient _httpClient = HttpClient();

  // Get all categories
  Future<ApiResponse<List<Category>>> getCategories() async {
    try {
      final response = await _httpClient.get(ApiConfig.categories);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final categories = data.map((json) => Category.fromJson(json)).toList();

        return ApiResponse<List<Category>>(success: true, data: categories);
      } else {
        return ApiResponse<List<Category>>(
          success: false,
          message: 'Failed to get categories',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<List<Category>>(e);
    } catch (e) {
      return ApiResponse<List<Category>>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get category by ID
  Future<ApiResponse<Category>> getCategory(int id) async {
    try {
      final response = await _httpClient.get('${ApiConfig.categories}/$id');

      if (response.statusCode == 200) {
        final category = Category.fromJson(response.data);
        return ApiResponse<Category>(success: true, data: category);
      } else {
        return ApiResponse<Category>(
          success: false,
          message: 'Failed to get category',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<Category>(e);
    } catch (e) {
      return ApiResponse<Category>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Create new category
  Future<ApiResponse<Category>> createCategory(
    CategoryCreateRequest request,
  ) async {
    try {
      final response = await _httpClient.post(
        ApiConfig.categories,
        data: request.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final category = Category.fromJson(response.data);
        return ApiResponse<Category>(
          success: true,
          data: category,
          message: 'Category created successfully',
        );
      } else {
        return ApiResponse<Category>(
          success: false,
          message: 'Failed to create category',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<Category>(e);
    } catch (e) {
      return ApiResponse<Category>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Update category
  Future<ApiResponse<Category>> updateCategory(
    int id,
    CategoryUpdateRequest request,
  ) async {
    try {
      final response = await _httpClient.put(
        '${ApiConfig.categories}/$id',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final category = Category.fromJson(response.data);
        return ApiResponse<Category>(
          success: true,
          data: category,
          message: 'Category updated successfully',
        );
      } else {
        return ApiResponse<Category>(
          success: false,
          message: 'Failed to update category',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<Category>(e);
    } catch (e) {
      return ApiResponse<Category>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Delete category
  Future<ApiResponse<void>> deleteCategory(int id) async {
    try {
      final response = await _httpClient.delete('${ApiConfig.categories}/$id');

      if (response.statusCode == 204 || response.statusCode == 200) {
        return ApiResponse<void>(
          success: true,
          message: 'Category deleted successfully',
        );
      } else {
        return ApiResponse<void>(
          success: false,
          message: 'Failed to delete category',
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

  // Get categories by type
  Future<ApiResponse<List<Category>>> getCategoriesByType(
    CategoryType type,
  ) async {
    try {
      final response = await _httpClient.get(
        ApiConfig.categories,
        queryParameters: {'type': type.name},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final categories = data.map((json) => Category.fromJson(json)).toList();

        return ApiResponse<List<Category>>(success: true, data: categories);
      } else {
        return ApiResponse<List<Category>>(
          success: false,
          message: 'Failed to get categories by type',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<List<Category>>(e);
    } catch (e) {
      return ApiResponse<List<Category>>(
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
          message = 'Category not found';
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
