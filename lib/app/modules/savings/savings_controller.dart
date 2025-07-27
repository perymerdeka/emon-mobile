import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingsController extends GetxController {
  final goals = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final totalGoals = 0.obs;
  final totalSaved = 0.0.obs;
  final completedGoals = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadGoals();
  }

  void loadGoals() {
    isLoading.value = true;

    // Simulate API call
    Future.delayed(Duration(milliseconds: 500), () {
      goals.value = [
        {
          'title': 'Vacation Fund',
          'target': 3000.00,
          'saved': 2100.00,
          'icon': Icons.flight,
          'color': Color(0xFF2196F3),
          'deadline': '2024-06-15',
          'isCompleted': false,
        },
        {
          'title': 'Emergency Fund',
          'target': 5000.00,
          'saved': 5000.00,
          'icon': Icons.security,
          'color': Color(0xFF4CAF50),
          'deadline': '2024-03-01',
          'isCompleted': true,
        },
        {
          'title': 'New Laptop',
          'target': 1500.00,
          'saved': 800.00,
          'icon': Icons.laptop,
          'color': Color(0xFF9C27B0),
          'deadline': '2024-05-20',
          'isCompleted': false,
        },
        {
          'title': 'Home Renovation',
          'target': 2000.00,
          'saved': 350.00,
          'icon': Icons.home,
          'color': Color(0xFFFF9800),
          'deadline': '2024-08-30',
          'isCompleted': false,
        },
      ];

      _updateSummary();
      isLoading.value = false;
    });
  }

  void _updateSummary() {
    totalGoals.value = goals.length;
    totalSaved.value = goals.fold(0.0, (sum, goal) => sum + goal['saved']);
    completedGoals.value = goals
        .where((goal) => goal['isCompleted'] == true)
        .length;
  }

  void createGoal(Map<String, dynamic> goalData) {
    // TODO: Implement API call to create goal
    Get.snackbar(
      'Success',
      'Goal created successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void addMoneyToGoal(String title, double amount) {
    // TODO: Implement API call to add money to goal
    Get.snackbar(
      'Success',
      'Money added to goal successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void updateGoal(String title, Map<String, dynamic> goalData) {
    // TODO: Implement API call to update goal
    Get.snackbar(
      'Success',
      'Goal updated successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void deleteGoal(String title) {
    // TODO: Implement API call to delete goal
    Get.snackbar(
      'Success',
      'Goal deleted successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  double getGoalProgress(String title) {
    final goal = goals.firstWhere((g) => g['title'] == title);
    return goal['saved'] / goal['target'];
  }

  bool isGoalCompleted(String title) {
    final goal = goals.firstWhere((g) => g['title'] == title);
    return goal['isCompleted'] == true;
  }

  double getOverallProgress() {
    if (goals.isEmpty) return 0.0;
    final totalTarget = goals.fold(0.0, (sum, goal) => sum + goal['target']);
    return totalSaved.value / totalTarget;
  }
}
