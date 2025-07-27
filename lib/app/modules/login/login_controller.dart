import 'package:get/get.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';
import '../../data/services/auth_service.dart';
import '../../data/models/user_model.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  // Observable variables
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final email = ''.obs;
  final password = ''.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize auth service
    _authService.initialize();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Update email
  void updateEmail(String value) {
    email.value = value;
    clearError();
  }

  // Update password
  void updatePassword(String value) {
    password.value = value;
    clearError();
  }

  // Clear error message
  void clearError() {
    if (errorMessage.value.isNotEmpty) {
      errorMessage.value = '';
    }
  }

  // Validate form
  bool _validateForm() {
    if (email.value.isEmpty) {
      errorMessage.value = 'Email harus diisi';
      return false;
    }

    if (!GetUtils.isEmail(email.value)) {
      errorMessage.value = 'Format email tidak valid';
      return false;
    }

    if (password.value.isEmpty) {
      errorMessage.value = 'Password harus diisi';
      return false;
    }

    if (password.value.length < 6) {
      errorMessage.value = 'Password minimal 6 karakter';
      return false;
    }

    return true;
  }

  // Login method
  Future<void> login() async {
    if (!_validateForm()) {
      return;
    }

    isLoading.value = true;
    clearError();

    try {
      final request = UserLoginRequest(
        username: email.value,
        password: password.value,
      );

      final response = await _authService.login(request);

      if (response.success) {
        // Login successful
        Get.snackbar(
          'Sukses',
          'Login berhasil',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );

        // Navigate to home
        Get.offAllNamed(Routes.HOME);
      } else {
        // Login failed
        errorMessage.value = response.message ?? 'Login gagal';
        Get.snackbar(
          'Error',
          response.message ?? 'Login gagal',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: ${e.toString()}';
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Check if user is already authenticated
  Future<void> checkAuthStatus() async {
    try {
      final isAuthenticated = await _authService.isAuthenticated();
      if (isAuthenticated) {
        // User is already logged in, navigate to home
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      // Ignore error, user needs to login
    }
  }

  // Navigate to register
  void goToRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  // Navigate to forgot password
  void goToForgotPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }
}
