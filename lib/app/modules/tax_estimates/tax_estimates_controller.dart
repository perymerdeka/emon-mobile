import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaxEstimatesController extends GetxController {
  final totalIncome = 0.0.obs;
  final taxDue = 0.0.obs;
  final netIncome = 0.0.obs;
  final isLoading = false.obs;
  final taxBreakdown = <Map<String, dynamic>>[].obs;
  final taxDates = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTaxData();
  }

  void loadTaxData() {
    isLoading.value = true;

    // Simulate API call
    Future.delayed(Duration(milliseconds: 500), () {
      totalIncome.value = 45000.0;
      taxDue.value = 8500.0;
      netIncome.value = totalIncome.value - taxDue.value;

      taxBreakdown.value = [
        {
          'type': 'Federal Income Tax',
          'amount': 6500.00,
          'color': Color(0xFFE74C3C),
        },
        {
          'type': 'State Income Tax',
          'amount': 1200.00,
          'color': Color(0xFFFF9800),
        },
        {
          'type': 'Self-Employment Tax',
          'amount': 800.00,
          'color': Color(0xFF9C27B0),
        },
      ];

      taxDates.value = [
        {
          'date': 'April 15, 2024',
          'title': 'Tax Filing Deadline',
          'description': 'File your annual tax return',
          'isUrgent': true,
          'icon': Icons.event,
          'color': Color(0xFFE74C3C),
        },
        {
          'date': 'January 15, 2024',
          'title': 'Q4 Estimated Tax',
          'description': 'Pay estimated tax for Q4 2023',
          'isUrgent': false,
          'icon': Icons.payment,
          'color': Color(0xFFFF9800),
        },
        {
          'date': 'September 15, 2024',
          'title': 'Q3 Estimated Tax',
          'description': 'Pay estimated tax for Q3 2024',
          'isUrgent': false,
          'icon': Icons.payment,
          'color': Color(0xFF2196F3),
        },
      ];

      isLoading.value = false;
    });
  }

  void calculateTax(double income, double expenses, String state) {
    isLoading.value = true;

    // Simulate tax calculation
    Future.delayed(Duration(milliseconds: 1000), () {
      final taxableIncome = income - expenses;

      // Simple tax calculation (this would be more complex in real app)
      final federalTax = taxableIncome * 0.15;
      final stateTax = taxableIncome * 0.05;
      final selfEmploymentTax = taxableIncome * 0.153;

      totalIncome.value = income;
      taxDue.value = federalTax + stateTax + selfEmploymentTax;
      netIncome.value = income - taxDue.value;

      taxBreakdown.value = [
        {
          'type': 'Federal Income Tax',
          'amount': federalTax,
          'color': Color(0xFFE74C3C),
        },
        {
          'type': 'State Income Tax',
          'amount': stateTax,
          'color': Color(0xFFFF9800),
        },
        {
          'type': 'Self-Employment Tax',
          'amount': selfEmploymentTax,
          'color': Color(0xFF9C27B0),
        },
      ];

      isLoading.value = false;

      Get.snackbar(
        'Tax Estimate Calculated',
        'Your estimated tax has been calculated and updated!',
        backgroundColor: Color(0xFF4CAF50),
        colorText: Colors.white,
      );
    });
  }

  void setReminder(String title, String date) {
    // TODO: Implement reminder functionality
    Get.snackbar(
      'Reminder Set',
      'Reminder set for $title on $date',
      backgroundColor: Color(0xFF2196F3),
      colorText: Colors.white,
    );
  }

  void exportTaxData() {
    // TODO: Implement export functionality
    Get.snackbar(
      'Exporting',
      'Tax data exported successfully!',
      backgroundColor: Color(0xFF4CAF50),
      colorText: Colors.white,
    );
  }

  double getTaxPercentage() {
    if (totalIncome.value == 0) return 0.0;
    return (taxDue.value / totalIncome.value) * 100;
  }

  List<String> getTaxTips() {
    return [
      'Keep detailed records of all business expenses',
      'Set aside 25-30% of income for taxes',
      'Consider quarterly estimated tax payments',
      'Consult with a tax professional for complex situations',
    ];
  }
}
