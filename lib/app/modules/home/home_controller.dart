import 'package:get/get.dart';
import '../../data/services/transaction_service.dart';
import '../../data/services/budget_service.dart';
import '../../data/services/notification_service.dart';
import '../../data/models/transaction_model.dart';
import '../../data/models/budget_model.dart';
import '../../data/models/notification_model.dart';
import '../../data/models/category_model.dart';

class HomeController extends GetxController {
  final TransactionService _transactionService = TransactionService();
  final BudgetService _budgetService = BudgetService();
  final NotificationService _notificationService = NotificationService();

  // Observable variables
  final isLoading = false.obs;
  final recentTransactions = <Transaction>[].obs;
  final currentBudgets = <Budget>[].obs;
  final unreadNotifications = <Notification>[].obs;
  final errorMessage = ''.obs;

  // Dashboard summary
  final totalIncome = 0.0.obs;
  final totalExpense = 0.0.obs;
  final netIncome = 0.0.obs;
  final unreadNotificationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  // Load all dashboard data
  Future<void> loadDashboardData() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Load data in parallel
      await Future.wait([
        loadRecentTransactions(),
        loadCurrentBudgets(),
        loadUnreadNotifications(),
        loadMonthlySummary(),
      ]);
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

  // Load recent transactions
  Future<void> loadRecentTransactions() async {
    try {
      final response = await _transactionService.getRecentTransactions(5);
      if (response.success && response.data != null) {
        recentTransactions.value = response.data!;
      }
    } catch (e) {
      // Ignore error for recent transactions
    }
  }

  // Load current month budgets
  Future<void> loadCurrentBudgets() async {
    try {
      final response = await _budgetService.getCurrentMonthBudgets();
      if (response.success && response.data != null) {
        currentBudgets.value = response.data!;
      }
    } catch (e) {
      // Ignore error for budgets
    }
  }

  // Load unread notifications
  Future<void> loadUnreadNotifications() async {
    try {
      final response = await _notificationService.getUnreadNotifications();
      if (response.success && response.data != null) {
        unreadNotifications.value = response.data!;
        unreadNotificationCount.value = response.data!.length;
      }
    } catch (e) {
      // Ignore error for notifications
    }
  }

  // Load monthly summary
  Future<void> loadMonthlySummary() async {
    try {
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      final endOfMonth = DateTime(now.year, now.month + 1, 0);

      final response = await _transactionService.getTransactionsByDateRange(
        startOfMonth,
        endOfMonth,
      );

      if (response.success && response.data != null) {
        final transactions = response.data!;

        totalIncome.value = transactions
            .where((tx) => tx.type == CategoryType.income)
            .fold(0.0, (sum, tx) => sum + tx.amount);

        totalExpense.value = transactions
            .where((tx) => tx.type == CategoryType.expense)
            .fold(0.0, (sum, tx) => sum + tx.amount);

        netIncome.value = totalIncome.value - totalExpense.value;
      }
    } catch (e) {
      // Ignore error for summary
    }
  }

  // Mark notification as read
  Future<void> markNotificationAsRead(int id) async {
    try {
      final response = await _notificationService.markAsRead(id);
      if (response.success) {
        // Remove from unread list
        unreadNotifications.removeWhere(
          (notification) => notification.id == id,
        );
        unreadNotificationCount.value = unreadNotifications.length;
      }
    } catch (e) {
      // Ignore error
    }
  }

  // Get budget progress percentage
  double getBudgetProgress(Budget budget) {
    if (budget.spent == null || budget.amount <= 0) return 0.0;
    return (budget.spent! / budget.amount).clamp(0.0, 1.0);
  }

  // Get budget status color
  String getBudgetStatusColor(Budget budget) {
    if (budget.spent == null) return '#4CAF50'; // Green
    if (budget.spent! > budget.amount) return '#F44336'; // Red
    if (budget.spent! > (budget.amount * 0.8)) return '#FF9800'; // Orange
    return '#4CAF50'; // Green
  }

  // Get budget status text
  String getBudgetStatusText(Budget budget) {
    if (budget.spent == null) return 'Belum ada pengeluaran';
    if (budget.spent! > budget.amount) return 'Melebihi budget';
    if (budget.spent! > (budget.amount * 0.8)) return 'Hampir habis';
    return 'Masih aman';
  }

  // Refresh dashboard
  Future<void> refreshDashboard() async {
    await loadDashboardData();
  }

  // Navigate to transactions
  void goToTransactions() {
    Get.toNamed('/transactions');
  }

  // Navigate to budgets
  void goToBudgets() {
    Get.toNamed('/budgets');
  }

  // Navigate to notifications
  void goToNotifications() {
    Get.toNamed('/notifications');
  }

  // Navigate to reports
  void goToReports() {
    Get.toNamed('/reports');
  }
}
