import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class InvoicesView extends StatelessWidget {
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
          'Invoices',
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
              onTap: () => _showCreateInvoiceDialog(),
              child: CircleAvatar(
                backgroundColor: Color(0xFF2196F3),
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
                            'Total Invoices',
                            '12',
                            Icons.receipt_long,
                            Color(0xFF2196F3),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            'Paid',
                            '8',
                            Icons.check_circle,
                            Color(0xFF4CAF50),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            'Pending',
                            '4',
                            Icons.pending,
                            Color(0xFFFF9800),
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
                        _filterButton('Date'),
                        SizedBox(width: 12),
                        _filterButton('Client'),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Invoice List
                    Text(
                      'Recent Invoices',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 400 ? 16 : 18,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    SizedBox(height: 12),

                    // Sample Invoice Items
                    _invoiceCard({
                      'id': 'INV-001',
                      'client': 'John Doe',
                      'amount': 1500.00,
                      'status': 'paid',
                      'date': '2024-01-15',
                      'dueDate': '2024-01-30',
                    }, size),
                    _invoiceCard({
                      'id': 'INV-002',
                      'client': 'Jane Smith',
                      'amount': 2500.00,
                      'status': 'pending',
                      'date': '2024-01-20',
                      'dueDate': '2024-02-05',
                    }, size),
                    _invoiceCard({
                      'id': 'INV-003',
                      'client': 'Bob Johnson',
                      'amount': 800.00,
                      'status': 'paid',
                      'date': '2024-01-10',
                      'dueDate': '2024-01-25',
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
        // TODO: Implement filter functionality
        Get.snackbar(
          'Info',
          '$label filter will be implemented here',
          backgroundColor: Color(0xFF2196F3),
          colorText: Colors.white,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFFE3F0FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(color: Color(0xFF2196F3), fontSize: 16),
            ),
            Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF2196F3)),
          ],
        ),
      ),
    ),
  );
}

Widget _invoiceCard(Map invoice, Size size) {
  final isPaid = invoice['status'] == 'paid';
  return GestureDetector(
    onTap: () => _showInvoiceDetails(invoice),
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
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: isPaid ? Color(0xFFE8F5E8) : Color(0xFFFFF3E0),
            child: Icon(
              isPaid ? Icons.check_circle : Icons.pending,
              color: isPaid ? Color(0xFF4CAF50) : Color(0xFFFF9800),
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice['id'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF181F2B),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  invoice['client'],
                  style: TextStyle(fontSize: 14, color: Color(0xFF8A94A6)),
                ),
                SizedBox(height: 4),
                Text(
                  'Due: ${invoice['dueDate']}',
                  style: TextStyle(fontSize: 12, color: Color(0xFF8A94A6)),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${invoice['amount'].toStringAsFixed(2)}',
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
                  color: isPaid ? Color(0xFFE8F5E8) : Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isPaid ? 'Paid' : 'Pending',
                  style: TextStyle(
                    fontSize: 12,
                    color: isPaid ? Color(0xFF4CAF50) : Color(0xFFFF9800),
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

void _showCreateInvoiceDialog() {
  Get.dialog(
    AlertDialog(
      title: Text('Create New Invoice'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Client Name',
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
          TextField(
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
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
              'Invoice created successfully!',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          },
          child: Text('Create'),
        ),
      ],
    ),
  );
}

void _showInvoiceDetails(Map invoice) {
  final isPaid = invoice['status'] == 'paid';
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
                backgroundColor: isPaid ? Color(0xFFE8F5E8) : Color(0xFFFFF3E0),
                child: Icon(
                  isPaid ? Icons.check_circle : Icons.pending,
                  color: isPaid ? Color(0xFF4CAF50) : Color(0xFFFF9800),
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice['id'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    Text(
                      invoice['client'],
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
                '\$${invoice['amount'].toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF181F2B),
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
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      'Info',
                      'Send functionality will be implemented here',
                      backgroundColor: Color(0xFF4CAF50),
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4CAF50),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Send'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
