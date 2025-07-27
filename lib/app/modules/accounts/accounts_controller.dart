import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountsController extends GetxController {
  final accounts = <Map<String, dynamic>>[].obs;
  final availableBanks = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final totalBalance = 0.0.obs;
  final connectedAccounts = 0.obs;
  final lastSync = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadAccounts();
    loadAvailableBanks();
  }

  void loadAccounts() {
    isLoading.value = true;

    // Simulate API call
    Future.delayed(Duration(milliseconds: 500), () {
      accounts.value = [
        {
          'name': 'Chase Bank',
          'accountNumber': '****1234',
          'balance': 8500.00,
          'type': 'Checking',
          'icon': Icons.account_balance,
          'color': Color(0xFF2196F3),
          'isConnected': true,
          'lastTransaction': '2 hours ago',
        },
        {
          'name': 'Wells Fargo',
          'accountNumber': '****5678',
          'balance': 3200.00,
          'type': 'Savings',
          'icon': Icons.savings,
          'color': Color(0xFF4CAF50),
          'isConnected': true,
          'lastTransaction': '1 day ago',
        },
        {
          'name': 'Bank of America',
          'accountNumber': '****9012',
          'balance': 750.00,
          'type': 'Credit Card',
          'icon': Icons.credit_card,
          'color': Color(0xFFE74C3C),
          'isConnected': true,
          'lastTransaction': '3 days ago',
        },
      ];

      _updateSummary();
      isLoading.value = false;
    });
  }

  void loadAvailableBanks() {
    availableBanks.value = [
      {
        'name': 'Citibank',
        'description': 'Connect your Citibank account',
        'icon': Icons.account_balance,
        'color': Color(0xFF9C27B0),
      },
      {
        'name': 'American Express',
        'description': 'Connect your Amex account',
        'icon': Icons.credit_card,
        'color': Color(0xFF607D8B),
      },
    ];
  }

  void _updateSummary() {
    totalBalance.value = accounts.fold(
      0.0,
      (sum, account) => sum + account['balance'],
    );
    connectedAccounts.value = accounts
        .where((account) => account['isConnected'] == true)
        .length;
    lastSync.value = '2h ago';
  }

  void addAccount(Map<String, dynamic> accountData) {
    // TODO: Implement API call to add account
    Get.snackbar(
      'Success',
      'Bank account added successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void syncAccount(String accountId) {
    // TODO: Implement API call to sync account
    Get.snackbar(
      'Syncing',
      'Syncing account data...',
      backgroundColor: Color(0xFF2196F3),
      colorText: Colors.white,
    );
  }

  void syncAllAccounts() {
    // TODO: Implement API call to sync all accounts
    Get.snackbar(
      'Syncing',
      'Syncing all connected accounts...',
      backgroundColor: Color(0xFF2196F3),
      colorText: Colors.white,
    );
  }

  void transferBetweenAccounts(
    String fromAccount,
    String toAccount,
    double amount,
  ) {
    // TODO: Implement API call to transfer
    Get.snackbar(
      'Success',
      'Transfer initiated successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void exportAccounts() {
    // TODO: Implement export functionality
    Get.snackbar(
      'Exporting',
      'Exporting account data...',
      backgroundColor: Color(0xFFFF9800),
      colorText: Colors.white,
    );
  }

  void connectBank(String bankName) {
    // TODO: Implement bank connection
    Get.snackbar(
      'Connecting',
      'Connecting to $bankName...',
      backgroundColor: Color(0xFF4CAF50),
      colorText: Colors.white,
    );
  }

  void disconnectAccount(String accountId) {
    // TODO: Implement disconnect functionality
    Get.snackbar(
      'Success',
      'Account disconnected successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  Map<String, dynamic>? getAccountById(String accountId) {
    try {
      return accounts.firstWhere(
        (account) => account['accountNumber'] == accountId,
      );
    } catch (e) {
      return null;
    }
  }

  double getTotalBalance() {
    return accounts.fold(0.0, (sum, account) => sum + account['balance']);
  }
}
