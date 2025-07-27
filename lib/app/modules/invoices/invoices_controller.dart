import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoicesController extends GetxController {
  final invoices = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final totalInvoices = 0.obs;
  final paidInvoices = 0.obs;
  final pendingInvoices = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadInvoices();
  }

  void loadInvoices() {
    isLoading.value = true;

    // Simulate API call
    Future.delayed(Duration(milliseconds: 500), () {
      invoices.value = [
        {
          'id': 'INV-001',
          'client': 'John Doe',
          'amount': 1500.00,
          'status': 'paid',
          'date': '2024-01-15',
          'dueDate': '2024-01-30',
        },
        {
          'id': 'INV-002',
          'client': 'Jane Smith',
          'amount': 2500.00,
          'status': 'pending',
          'date': '2024-01-20',
          'dueDate': '2024-02-05',
        },
        {
          'id': 'INV-003',
          'client': 'Bob Johnson',
          'amount': 800.00,
          'status': 'paid',
          'date': '2024-01-10',
          'dueDate': '2024-01-25',
        },
      ];

      _updateSummary();
      isLoading.value = false;
    });
  }

  void _updateSummary() {
    totalInvoices.value = invoices.length;
    paidInvoices.value = invoices
        .where((inv) => inv['status'] == 'paid')
        .length;
    pendingInvoices.value = invoices
        .where((inv) => inv['status'] == 'pending')
        .length;
  }

  void createInvoice(Map<String, dynamic> invoiceData) {
    // TODO: Implement API call to create invoice
    Get.snackbar(
      'Success',
      'Invoice created successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void updateInvoice(String id, Map<String, dynamic> invoiceData) {
    // TODO: Implement API call to update invoice
    Get.snackbar(
      'Success',
      'Invoice updated successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void deleteInvoice(String id) {
    // TODO: Implement API call to delete invoice
    Get.snackbar(
      'Success',
      'Invoice deleted successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
