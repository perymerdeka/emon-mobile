import 'package:get/get.dart';
import '../../data/services/transaction_service.dart';
import '../../data/models/transaction_model.dart';
import '../../data/models/category_model.dart';

class TransactionsController extends GetxController {
  final TransactionService _transactionService = TransactionService();

  // Observable variables
  final isLoading = false.obs;
  final transactions = <Transaction>[].obs;
  final recentTransactions = <Transaction>[].obs;
  final errorMessage = ''.obs;

  // Filter variables
  final selectedCategoryId = 0.obs;
  final selectedType = ''.obs;
  final startDate = DateTime.now().subtract(Duration(days: 30)).obs;
  final endDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  // Load all transactions
  Future<void> loadTransactions() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final filter = TransactionFilter(
        startDate: startDate.value,
        endDate: endDate.value,
        categoryId: selectedCategoryId.value > 0
            ? selectedCategoryId.value
            : null,
        type: selectedType.value.isNotEmpty
            ? (selectedType.value == 'income'
                  ? CategoryType.income
                  : CategoryType.expense)
            : null,
      );

      final response = await _transactionService.getTransactions(filter);

      if (response.success && response.data != null) {
        transactions.value = response.data!;
      } else {
        errorMessage.value = response.message ?? 'Gagal memuat transaksi';
        Get.snackbar(
          'Error',
          response.message ?? 'Gagal memuat transaksi',
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

  // Load recent transactions
  Future<void> loadRecentTransactions([int limit = 5]) async {
    try {
      final response = await _transactionService.getRecentTransactions(limit);

      if (response.success && response.data != null) {
        recentTransactions.value = response.data!;
      }
    } catch (e) {
      // Ignore error for recent transactions
    }
  }

  // Create new transaction
  Future<void> createTransaction(TransactionCreateRequest request) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _transactionService.createTransaction(request);

      if (response.success && response.data != null) {
        // Add new transaction to list
        transactions.insert(0, response.data!);

        // Update recent transactions
        await loadRecentTransactions();

        Get.snackbar(
          'Sukses',
          'Transaksi berhasil dibuat',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      } else {
        errorMessage.value = response.message ?? 'Gagal membuat transaksi';
        Get.snackbar(
          'Error',
          response.message ?? 'Gagal membuat transaksi',
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

  // Update transaction
  Future<void> updateTransaction(
    int id,
    TransactionUpdateRequest request,
  ) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _transactionService.updateTransaction(id, request);

      if (response.success && response.data != null) {
        // Update transaction in list
        final index = transactions.indexWhere((tx) => tx.id == id);
        if (index != -1) {
          transactions[index] = response.data!;
        }

        Get.snackbar(
          'Sukses',
          'Transaksi berhasil diperbarui',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      } else {
        errorMessage.value = response.message ?? 'Gagal memperbarui transaksi';
        Get.snackbar(
          'Error',
          response.message ?? 'Gagal memperbarui transaksi',
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

  // Delete transaction
  Future<void> deleteTransaction(int id) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _transactionService.deleteTransaction(id);

      if (response.success) {
        // Remove transaction from list
        transactions.removeWhere((tx) => tx.id == id);

        // Update recent transactions
        await loadRecentTransactions();

        Get.snackbar(
          'Sukses',
          'Transaksi berhasil dihapus',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      } else {
        errorMessage.value = response.message ?? 'Gagal menghapus transaksi';
        Get.snackbar(
          'Error',
          response.message ?? 'Gagal menghapus transaksi',
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

  // Filter transactions by category
  void filterByCategory(int categoryId) {
    selectedCategoryId.value = categoryId;
    loadTransactions();
  }

  // Filter transactions by type
  void filterByType(String type) {
    selectedType.value = type;
    loadTransactions();
  }

  // Filter transactions by date range
  void filterByDateRange(DateTime start, DateTime end) {
    startDate.value = start;
    endDate.value = end;
    loadTransactions();
  }

  // Clear filters
  void clearFilters() {
    selectedCategoryId.value = 0;
    selectedType.value = '';
    startDate.value = DateTime.now().subtract(Duration(days: 30));
    endDate.value = DateTime.now();
    loadTransactions();
  }

  // Get transaction by ID
  Transaction? getTransactionById(int id) {
    try {
      return transactions.firstWhere((tx) => tx.id == id);
    } catch (e) {
      return null;
    }
  }

  // Calculate total income
  double get totalIncome {
    return transactions
        .where((tx) => tx.type == CategoryType.income)
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  // Calculate total expense
  double get totalExpense {
    return transactions
        .where((tx) => tx.type == CategoryType.expense)
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  // Calculate net income
  double get netIncome {
    return totalIncome - totalExpense;
  }

  // Refresh transactions
  Future<void> refreshTransactions() async {
    await loadTransactions();
    await loadRecentTransactions();
  }
}
