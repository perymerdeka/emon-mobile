import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillsView extends StatelessWidget {
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
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF181F2B)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Bills',
          style: TextStyle(
            color: Color(0xFF181F2B),
            fontWeight: FontWeight.bold,
            fontSize: size.width < 400 ? 20 : 22,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => _showAddBillDialog(),
              child: CircleAvatar(
                backgroundColor: Color(0xFFE74C3C),
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
                    // Summary Cards
                    Row(
                      children: [
                        Expanded(
                          child: _summaryCard(
                            'Total Bills',
                            '8',
                            Icons.receipt_long,
                            Color(0xFFE74C3C),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            'Paid',
                            '5',
                            Icons.check_circle,
                            Color(0xFF4CAF50),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            'Overdue',
                            '2',
                            Icons.warning,
                            Color(0xFFFF5722),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Filter Section
                    Row(
                      children: [
                        _filterButton('Status'),
                        SizedBox(width: 12),
                        _filterButton('Category'),
                        SizedBox(width: 12),
                        _filterButton('Due Date'),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Bills List
                    Text(
                      'Upcoming Bills',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 400 ? 16 : 18,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    SizedBox(height: 12),

                    // Sample Bill Items
                    _billCard({
                      'id': 'BILL-001',
                      'title': 'Electricity Bill',
                      'amount': 85.50,
                      'status': 'pending',
                      'dueDate': '2024-02-01',
                      'category': 'Utilities',
                      'isOverdue': false,
                    }, size),
                    _billCard({
                      'id': 'BILL-002',
                      'title': 'Internet Bill',
                      'amount': 65.00,
                      'status': 'paid',
                      'dueDate': '2024-01-25',
                      'category': 'Utilities',
                      'isOverdue': false,
                    }, size),
                    _billCard({
                      'id': 'BILL-003',
                      'title': 'Credit Card',
                      'amount': 450.00,
                      'status': 'overdue',
                      'dueDate': '2024-01-20',
                      'category': 'Credit',
                      'isOverdue': true,
                    }, size),
                    _billCard({
                      'id': 'BILL-004',
                      'title': 'Phone Bill',
                      'amount': 35.00,
                      'status': 'pending',
                      'dueDate': '2024-02-05',
                      'category': 'Utilities',
                      'isOverdue': false,
                    }, size),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _summaryCard(String title, String value, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF181F2B),
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Color(0xFF8A94A6)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _filterButton(String label) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        Get.snackbar(
          'Info',
          '$label filter will be implemented here',
          backgroundColor: Color(0xFFE74C3C),
          colorText: Colors.white,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(color: Color(0xFFE74C3C), fontSize: 16),
            ),
            Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFFE74C3C)),
          ],
        ),
      ),
    ),
  );
}

Widget _billCard(Map bill, Size size) {
  final isPaid = bill['status'] == 'paid';
  final isOverdue = bill['isOverdue'] == true;

  Color statusColor;
  IconData statusIcon;
  String statusText;

  if (isPaid) {
    statusColor = Color(0xFF4CAF50);
    statusIcon = Icons.check_circle;
    statusText = 'Paid';
  } else if (isOverdue) {
    statusColor = Color(0xFFFF5722);
    statusIcon = Icons.warning;
    statusText = 'Overdue';
  } else {
    statusColor = Color(0xFFFF9800);
    statusIcon = Icons.pending;
    statusText = 'Pending';
  }

  return GestureDetector(
    onTap: () => _showBillDetails(bill),
    child: Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: isOverdue
            ? Border.all(color: Color(0xFFFF5722).withOpacity(0.3), width: 2)
            : null,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: statusColor.withOpacity(0.2),
            child: Icon(statusIcon, color: statusColor, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bill['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF181F2B),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  bill['category'],
                  style: TextStyle(fontSize: 14, color: Color(0xFF8A94A6)),
                ),
                SizedBox(height: 4),
                Text(
                  'Due: ${bill['dueDate']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isOverdue ? Color(0xFFFF5722) : Color(0xFF8A94A6),
                    fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${bill['amount'].toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF181F2B),
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

void _showAddBillDialog() {
  Get.dialog(
    AlertDialog(
      title: Text('Add New Bill'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Bill Title',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(value: 'Utilities', child: Text('Utilities')),
              DropdownMenuItem(value: 'Credit', child: Text('Credit')),
              DropdownMenuItem(value: 'Insurance', child: Text('Insurance')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            onChanged: (value) {},
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Due Date',
              border: OutlineInputBorder(),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: Get.context!,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );
              if (picked != null) {
                // Handle date selection
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            Get.back();
            Get.snackbar(
              'Success',
              'Bill added successfully!',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          },
          child: Text('Add'),
        ),
      ],
    ),
  );
}

void _showBillDetails(Map bill) {
  final isPaid = bill['status'] == 'paid';
  final isOverdue = bill['isOverdue'] == true;

  Color statusColor;
  IconData statusIcon;
  String statusText;

  if (isPaid) {
    statusColor = Color(0xFF4CAF50);
    statusIcon = Icons.check_circle;
    statusText = 'Paid';
  } else if (isOverdue) {
    statusColor = Color(0xFFFF5722);
    statusIcon = Icons.warning;
    statusText = 'Overdue';
  } else {
    statusColor = Color(0xFFFF9800);
    statusIcon = Icons.pending;
    statusText = 'Pending';
  }

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
                backgroundColor: statusColor.withOpacity(0.2),
                child: Icon(statusIcon, color: statusColor, size: 20),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bill['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    Text(
                      bill['category'],
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
                '\$${bill['amount'].toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF181F2B),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Due Date:',
                style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
              ),
              Text(
                bill['dueDate'],
                style: TextStyle(
                  fontSize: 16,
                  color: isOverdue ? Color(0xFFFF5722) : Color(0xFF181F2B),
                  fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          if (!isPaid) ...[
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.snackbar(
                        'Info',
                        'Pay bill functionality will be implemented here',
                        backgroundColor: Color(0xFF4CAF50),
                        colorText: Colors.white,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4CAF50),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text('Pay Now'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.snackbar(
                        'Info',
                        'Edit functionality will be implemented here',
                        backgroundColor: Color(0xFF2196F3),
                        colorText: Colors.white,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2196F3),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text('Edit'),
                  ),
                ),
              ],
            ),
          ] else ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    'Info',
                    'View receipt functionality will be implemented here',
                    backgroundColor: Color(0xFF2196F3),
                    colorText: Colors.white,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2196F3),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('View Receipt'),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
