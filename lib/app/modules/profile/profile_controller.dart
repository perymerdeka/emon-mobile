import 'package:get/get.dart';
import '../../data/services/auth_service.dart';
import '../../data/models/user_model.dart';

class ProfileController extends GetxController {
  final AuthService _authService = AuthService();

  // Observable variables
  final isLoading = false.obs;
  final user = Rxn<User>();
  final errorMessage = ''.obs;

  // Settings
  final isDarkMode = false.obs;
  final showNotifDropdown = false.obs;
  final transactionAlerts = false.obs;
  final budgetReminders = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  // Load user profile
  Future<void> loadUserProfile() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _authService.getProfile();

      if (response.success && response.data != null) {
        user.value = response.data!;
      } else {
        errorMessage.value = response.message ?? 'Gagal memuat profil';
        Get.snackbar(
          'Error',
          response.message ?? 'Gagal memuat profil',
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

  // Change password
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final request = ChangePasswordRequest(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      final response = await _authService.changePassword(request);

      if (response.success) {
        Get.snackbar(
          'Sukses',
          'Password berhasil diubah',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      } else {
        errorMessage.value = response.message ?? 'Gagal mengubah password';
        Get.snackbar(
          'Error',
          response.message ?? 'Gagal mengubah password',
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

  // Logout
  Future<void> logout() async {
    isLoading.value = true;

    try {
      await _authService.logout();

      Get.snackbar(
        'Sukses',
        'Logout berhasil',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
      );

      // Navigate to login
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat logout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Toggle dark mode
  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    // TODO: Implement theme switching
  }

  // Toggle notification dropdown
  void toggleNotifDropdown() {
    showNotifDropdown.value = !showNotifDropdown.value;
  }

  // Toggle transaction alerts
  void toggleTransactionAlerts() {
    transactionAlerts.value = !transactionAlerts.value;
    // TODO: Save to backend
  }

  // Toggle budget reminders
  void toggleBudgetReminders() {
    budgetReminders.value = !budgetReminders.value;
    // TODO: Save to backend
  }

  // Get user name
  String get userName {
    return user.value?.email.split('@').first ?? 'User';
  }

  // Get user email
  String get userEmail {
    return user.value?.email ?? '';
  }

  // Get user avatar
  String get userAvatar {
    return 'assets/avatar_woman.png';
  }

  // Refresh profile
  Future<void> refreshProfile() async {
    await loadUserProfile();
  }
}
