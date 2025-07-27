import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/http_client.dart';
import '../../core/api_config.dart';
import '../../core/api_response.dart';
import '../models/user_model.dart';

class AuthService {
  final HttpClient _httpClient = HttpClient();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Initialize HTTP client
  void initialize() {
    _httpClient.initialize();
  }

  // Register new user
  Future<ApiResponse<User>> register(UserRegisterRequest request) async {
    try {
      // Mock response for testing (remove this when backend is ready)
      if (ApiConfig.baseUrl.contains('jsonplaceholder')) {
        // Simulate network delay
        await Future.delayed(Duration(seconds: 1));

        // Mock successful registration
        final mockUser = User(
          id: DateTime.now().millisecondsSinceEpoch,
          email: request.email,
          isActive: true,
        );

        return ApiResponse<User>(
          success: true,
          data: mockUser,
          message: 'Registration successful (Mock)',
        );
      }

      // Real API call (when backend is ready)
      final response = await _httpClient.post(
        ApiConfig.authRegister,
        data: request.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final user = User.fromJson(response.data);
        return ApiResponse<User>(
          success: true,
          data: user,
          message: 'Registration successful',
        );
      } else {
        return ApiResponse<User>(
          success: false,
          message: 'Registration failed',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<User>(e);
    } catch (e) {
      return ApiResponse<User>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Login user
  Future<ApiResponse<TokenResponse>> login(UserLoginRequest request) async {
    try {
      // Mock response for testing (remove this when backend is ready)
      if (ApiConfig.baseUrl.contains('jsonplaceholder')) {
        // Simulate network delay
        await Future.delayed(Duration(seconds: 1));

        // Mock successful login
        final mockTokenResponse = TokenResponse(
          accessToken:
              'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
          refreshToken:
              'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
          tokenType: 'bearer',
        );

        // Store tokens securely
        await _secureStorage.write(
          key: 'access_token',
          value: mockTokenResponse.accessToken,
        );
        await _secureStorage.write(
          key: 'refresh_token',
          value: mockTokenResponse.refreshToken,
        );

        return ApiResponse<TokenResponse>(
          success: true,
          data: mockTokenResponse,
          message: 'Login successful (Mock)',
        );
      }

      // Real API call (when backend is ready)
      final formData = FormData.fromMap({
        'username': request.username,
        'password': request.password,
      });

      final response = await _httpClient.post(
        ApiConfig.authLogin,
        data: formData,
      );

      if (response.statusCode == 200) {
        final tokenResponse = TokenResponse.fromJson(response.data);

        // Store tokens securely
        await _secureStorage.write(
          key: 'access_token',
          value: tokenResponse.accessToken,
        );
        await _secureStorage.write(
          key: 'refresh_token',
          value: tokenResponse.refreshToken,
        );

        return ApiResponse<TokenResponse>(
          success: true,
          data: tokenResponse,
          message: 'Login successful',
        );
      } else {
        return ApiResponse<TokenResponse>(
          success: false,
          message: 'Login failed',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<TokenResponse>(e);
    } catch (e) {
      return ApiResponse<TokenResponse>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Get current user profile
  Future<ApiResponse<User>> getProfile() async {
    try {
      // Mock response for testing (remove this when backend is ready)
      if (ApiConfig.baseUrl.contains('jsonplaceholder')) {
        // Simulate network delay
        await Future.delayed(Duration(milliseconds: 500));

        // Mock user profile
        final mockUser = User(id: 1, email: 'test@example.com', isActive: true);

        return ApiResponse<User>(success: true, data: mockUser);
      }

      // Real API call (when backend is ready)
      final response = await _httpClient.get(ApiConfig.authProfile);

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        return ApiResponse<User>(success: true, data: user);
      } else {
        return ApiResponse<User>(
          success: false,
          message: 'Failed to get profile',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<User>(e);
    } catch (e) {
      return ApiResponse<User>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Change password
  Future<ApiResponse<void>> changePassword(
    ChangePasswordRequest request,
  ) async {
    try {
      final response = await _httpClient.put(
        ApiConfig.authChangePassword,
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return ApiResponse<void>(
          success: true,
          message: 'Password changed successfully',
        );
      } else {
        return ApiResponse<void>(
          success: false,
          message: 'Failed to change password',
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

  // Refresh token
  Future<ApiResponse<TokenResponse>> refreshToken() async {
    try {
      final refreshToken = await _secureStorage.read(key: 'refresh_token');
      if (refreshToken == null) {
        return ApiResponse<TokenResponse>(
          success: false,
          message: 'No refresh token available',
        );
      }

      final response = await _httpClient.post(
        ApiConfig.authRefresh,
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final tokenResponse = TokenResponse.fromJson(response.data);

        // Update stored tokens
        await _secureStorage.write(
          key: 'access_token',
          value: tokenResponse.accessToken,
        );
        await _secureStorage.write(
          key: 'refresh_token',
          value: tokenResponse.refreshToken,
        );

        return ApiResponse<TokenResponse>(
          success: true,
          data: tokenResponse,
          message: 'Token refreshed successfully',
        );
      } else {
        return ApiResponse<TokenResponse>(
          success: false,
          message: 'Failed to refresh token',
        );
      }
    } on DioException catch (e) {
      return _handleDioError<TokenResponse>(e);
    } catch (e) {
      return ApiResponse<TokenResponse>(
        success: false,
        message: 'Unexpected error: ${e.toString()}',
      );
    }
  }

  // Logout
  Future<void> logout() async {
    await _httpClient.clearTokens();
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    return await _httpClient.isAuthenticated();
  }

  // Get stored access token
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
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
          message = 'Resource not found';
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
