import 'package:get/get.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';
import '../../data/services/auth_service.dart';
import '../../data/models/user_model.dart';

class RegisterController extends GetxController {
  final AuthService _authService = AuthService();

  // Observable variables
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
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
  void onClose() {
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
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

  // Update confirm password
  void updateConfirmPassword(String value) {
    confirmPassword.value = value;
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

    if (confirmPassword.value.isEmpty) {
      errorMessage.value = 'Konfirmasi password harus diisi';
      return false;
    }

    if (password.value != confirmPassword.value) {
      errorMessage.value = 'Password dan konfirmasi password tidak sama';
      return false;
    }

    return true;
  }

  // Register method
  Future<void> register() async {
    if (!_validateForm()) {
      return;
    }

    isLoading.value = true;
    clearError();

    try {
      final request = UserRegisterRequest(
        email: email.value,
        password: password.value,
      );

      final response = await _authService.register(request);

      if (response.success) {
        // Registration successful
        Get.snackbar(
          'Sukses',
          'Registrasi berhasil! Silakan login',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );

        // Navigate to login
        Get.offAllNamed(Routes.LOGIN);
      } else {
        // Registration failed
        errorMessage.value = response.message ?? 'Registrasi gagal';
        Get.snackbar(
          'Error',
          response.message ?? 'Registrasi gagal',
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

  // Navigate to login
  void goToLogin() {
    Get.offAllNamed(Routes.LOGIN);
  }
}
