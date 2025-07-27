import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetsController extends GetxController {
  final budgets = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final totalBudget = 0.0.obs;
  final totalSpent = 0.0.obs;
  final totalRemaining = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadBudgets();
  }

  void loadBudgets() {
    isLoading.value = true;

    // Simulate API call
    Future.delayed(Duration(milliseconds: 500), () {
      budgets.value = [
        {
          'category': 'Food & Dining',
          'budget': 500.00,
          'spent': 320.00,
          'icon': Icons.restaurant,
          'color': Color(0xFFFF5722),
        },
        {
          'category': 'Transportation',
          'budget': 300.00,
          'spent': 280.00,
          'icon': Icons.directions_car,
          'color': Color(0xFF2196F3),
        },
        {
          'category': 'Entertainment',
          'budget': 200.00,
          'spent': 150.00,
          'icon': Icons.movie,
          'color': Color(0xFF9C27B0),
        },
        {
          'category': 'Shopping',
          'budget': 400.00,
          'spent': 380.00,
          'icon': Icons.shopping_bag,
          'color': Color(0xFF4CAF50),
        },
        {
          'category': 'Utilities',
          'budget': 250.00,
          'spent': 180.00,
          'icon': Icons.power,
          'color': Color(0xFFFF9800),
        },
      ];

      _updateSummary();
      isLoading.value = false;
    });
  }

  void _updateSummary() {
    totalBudget.value = budgets.fold(
      0.0,
      (sum, budget) => sum + budget['budget'],
    );
    totalSpent.value = budgets.fold(
      0.0,
      (sum, budget) => sum + budget['spent'],
    );
    totalRemaining.value = totalBudget.value - totalSpent.value;
  }

  void createBudget(Map<String, dynamic> budgetData) {
    // TODO: Implement API call to create budget
    Get.snackbar(
      'Success',
      'Budget created successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void updateBudget(String category, Map<String, dynamic> budgetData) {
    // TODO: Implement API call to update budget
    Get.snackbar(
      'Success',
      'Budget updated successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void deleteBudget(String category) {
    // TODO: Implement API call to delete budget
    Get.snackbar(
      'Success',
      'Budget deleted successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  double getBudgetProgress(String category) {
    final budget = budgets.firstWhere((b) => b['category'] == category);
    return budget['spent'] / budget['budget'];
  }

  bool isOverBudget(String category) {
    return getBudgetProgress(category) > 1.0;
  }

  bool isNearLimit(String category) {
    final progress = getBudgetProgress(category);
    return progress > 0.8 && progress <= 1.0;
  }
}
