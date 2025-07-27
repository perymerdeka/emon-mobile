import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'transactions_controller.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';
import '../../data/models/transaction_model.dart';
import '../../data/models/category_model.dart';

class TransactionsView extends GetView<TransactionsController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.04 > 32 ? 32.0 : size.width * 0.04;
    final maxContentWidth = 500.0;
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Transactions',
          style: TextStyle(
            color: Color(0xFF181F2B),
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.ADD_TRANSACTION),
              child: CircleAvatar(
                backgroundColor: Color(0xFF3498F3),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 16,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _filterButton('Category'),
                        SizedBox(width: 12),
                        _filterButton('Date'),
                        SizedBox(width: 12),
                        _filterButton('Type'),
                      ],
                    ),
                    SizedBox(height: 24),
                    Obx(
                      () => Column(
                        children: controller.transactions
                            .map((tx) => _transactionCard(tx, size))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Color(0xFF3498F3),
        unselectedItemColor: Color(0xFF8A94A6),
        showUnselectedLabels: true,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.offAllNamed(Routes.HOME);
              break;
            case 1:
              Get.offAllNamed(Routes.TRANSACTIONS);
              break;
            case 2:
              Get.offAllNamed(Routes.REPORTS);
              break;
            case 3:
              Get.offAllNamed(Routes.PROFILE);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

Widget _filterButton(String label) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        // Show filter options based on label
        switch (label) {
          case 'Category':
            _showCategoryFilter();
            break;
          case 'Date':
            _showDateFilter();
            break;
          case 'Type':
            _showTypeFilter();
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFFE3F0FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(color: Color(0xFF3498F3), fontSize: 16),
            ),
            Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF3498F3)),
          ],
        ),
      ),
    ),
  );
}

void _showCategoryFilter() {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter by Category',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF181F2B),
            ),
          ),
          SizedBox(height: 20),
          // Add category filter options here
          Text('Category filter options will be implemented here'),
          SizedBox(height: 20),
        ],
      ),
    ),
  );
}

void _showDateFilter() {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter by Date',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF181F2B),
            ),
          ),
          SizedBox(height: 20),
          // Add date filter options here
          Text('Date filter options will be implemented here'),
          SizedBox(height: 20),
        ],
      ),
    ),
  );
}

void _showTypeFilter() {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter by Type',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF181F2B),
            ),
          ),
          SizedBox(height: 20),
          // Add type filter options here
          Text('Type filter options will be implemented here'),
          SizedBox(height: 20),
        ],
      ),
    ),
  );
}

void _showTransactionDetails(Transaction tx) {
  final isIncome = (tx.type == CategoryType.income);
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: isIncome
                    ? Color(0xFFDDF6F3)
                    : Color(0xFFFFE5E5),
                child: Icon(
                  isIncome
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  color: isIncome ? Color(0xFF2ECC71) : Color(0xFFE74C3C),
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.description ?? 'No description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    Text(
                      '${tx.date.day}/${tx.date.month}/${tx.date.year}',
                      style: TextStyle(fontSize: 14, color: Color(0xFF8A94A6)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount:',
                style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
              ),
              Text(
                (isIncome ? '' : '-') +
                    ' ${tx.amount.abs().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isIncome ? Color(0xFF2ECC71) : Color(0xFFE74C3C),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement edit functionality
                    Get.back();
                    Get.snackbar(
                      'Info',
                      'Edit functionality will be implemented here',
                      backgroundColor: Color(0xFF3498F3),
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3498F3),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Edit'),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement delete functionality
                    Get.back();
                    Get.snackbar(
                      'Info',
                      'Delete functionality will be implemented here',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Delete'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _transactionCard(Transaction tx, Size size) {
  final isIncome = (tx.type == CategoryType.income);
  return GestureDetector(
    onTap: () {
      _showTransactionDetails(tx);
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: isIncome ? Color(0xFFDDF6F3) : Color(0xFFFFE5E5),
            child: Icon(
              isIncome
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded,
              color: isIncome ? Color(0xFF2ECC71) : Color(0xFFE74C3C),
              size: 28,
            ),
          ),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (isIncome ? '' : '-') +
                      ' ${tx.amount.abs().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF181F2B),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  tx.description ?? 'No description',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF8A94A6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Text(
            '${tx.date.day}/${tx.date.month}/${tx.date.year}',
            style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
          ),
        ],
      ),
    ),
  );
}
