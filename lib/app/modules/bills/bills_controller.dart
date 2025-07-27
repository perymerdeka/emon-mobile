import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillsController extends GetxController {
  final bills = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final totalBills = 0.obs;
  final paidBills = 0.obs;
  final overdueBills = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadBills();
  }

  void loadBills() {
    isLoading.value = true;

    // Simulate API call
    Future.delayed(Duration(milliseconds: 500), () {
      bills.value = [
        {
          'id': 'BILL-001',
          'title': 'Electricity Bill',
          'amount': 85.50,
          'status': 'pending',
          'dueDate': '2024-02-01',
          'category': 'Utilities',
          'isOverdue': false,
        },
        {
          'id': 'BILL-002',
          'title': 'Internet Bill',
          'amount': 65.00,
          'status': 'paid',
          'dueDate': '2024-01-25',
          'category': 'Utilities',
          'isOverdue': false,
        },
        {
          'id': 'BILL-003',
          'title': 'Credit Card',
          'amount': 450.00,
          'status': 'overdue',
          'dueDate': '2024-01-20',
          'category': 'Credit',
          'isOverdue': true,
        },
        {
          'id': 'BILL-004',
          'title': 'Phone Bill',
          'amount': 35.00,
          'status': 'pending',
          'dueDate': '2024-02-05',
          'category': 'Utilities',
          'isOverdue': false,
        },
      ];

      _updateSummary();
      isLoading.value = false;
    });
  }

  void _updateSummary() {
    totalBills.value = bills.length;
    paidBills.value = bills.where((bill) => bill['status'] == 'paid').length;
    overdueBills.value = bills
        .where((bill) => bill['isOverdue'] == true)
        .length;
  }

  void addBill(Map<String, dynamic> billData) {
    // TODO: Implement API call to add bill
    Get.snackbar(
      'Success',
      'Bill added successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void payBill(String id) {
    // TODO: Implement API call to pay bill
    Get.snackbar(
      'Success',
      'Bill paid successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void updateBill(String id, Map<String, dynamic> billData) {
    // TODO: Implement API call to update bill
    Get.snackbar(
      'Success',
      'Bill updated successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void deleteBill(String id) {
    // TODO: Implement API call to delete bill
    Get.snackbar(
      'Success',
      'Bill deleted successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
