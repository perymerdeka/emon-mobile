import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class TaxEstimatesView extends StatelessWidget {
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
          'Tax Estimates',
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
              onTap: () => _showCalculateTaxDialog(),
              child: CircleAvatar(
                backgroundColor: Color(0xFFFF5722),
                child: Icon(Icons.calculate, color: Colors.white),
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
                            'Total Income',
                            '\$45,000',
                            Icons.trending_up,
                            Color(0xFF4CAF50),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            'Tax Due',
                            '\$8,500',
                            Icons.receipt_long,
                            Color(0xFFFF5722),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            'Net Income',
                            '\$36,500',
                            Icons.account_balance_wallet,
                            Color(0xFF2196F3),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Tax Breakdown
                    Container(
                      width: double.infinity,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tax Breakdown 2024',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF181F2B),
                            ),
                          ),
                          SizedBox(height: 16),
                          _taxBreakdownItem(
                            'Federal Income Tax',
                            6500.00,
                            Color(0xFFE74C3C),
                          ),
                          _taxBreakdownItem(
                            'State Income Tax',
                            1200.00,
                            Color(0xFFFF9800),
                          ),
                          _taxBreakdownItem(
                            'Self-Employment Tax',
                            800.00,
                            Color(0xFF9C27B0),
                          ),
                          Divider(height: 24),
                          _taxBreakdownItem(
                            'Total Tax Due',
                            8500.00,
                            Color(0xFFFF5722),
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    // Tax Calendar
                    Text(
                      'Important Tax Dates',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 400 ? 16 : 18,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    SizedBox(height: 12),

                    _taxDateCard({
                      'date': 'April 15, 2024',
                      'title': 'Tax Filing Deadline',
                      'description': 'File your annual tax return',
                      'isUrgent': true,
                      'icon': Icons.event,
                      'color': Color(0xFFE74C3C),
                    }, size),
                    _taxDateCard({
                      'date': 'January 15, 2024',
                      'title': 'Q4 Estimated Tax',
                      'description': 'Pay estimated tax for Q4 2023',
                      'isUrgent': false,
                      'icon': Icons.payment,
                      'color': Color(0xFFFF9800),
                    }, size),
                    _taxDateCard({
                      'date': 'September 15, 2024',
                      'title': 'Q3 Estimated Tax',
                      'description': 'Pay estimated tax for Q3 2024',
                      'isUrgent': false,
                      'icon': Icons.payment,
                      'color': Color(0xFF2196F3),
                    }, size),

                    SizedBox(height: 24),

                    // Tax Tips
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8F5E8),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Color(0xFF4CAF50).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb,
                                color: Color(0xFF4CAF50),
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Tax Tips',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF4CAF50),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          _taxTip(
                            'Keep detailed records of all business expenses',
                          ),
                          _taxTip('Set aside 25-30% of income for taxes'),
                          _taxTip('Consider quarterly estimated tax payments'),
                          _taxTip(
                            'Consult with a tax professional for complex situations',
                          ),
                        ],
                      ),
                    ),
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
            fontSize: 16,
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

Widget _taxBreakdownItem(
  String title,
  double amount,
  Color color, {
  bool isTotal = false,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Color(0xFF181F2B),
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _taxDateCard(Map taxDate, Size size) {
  return GestureDetector(
    onTap: () => _showTaxDateDetails(taxDate),
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
        border: taxDate['isUrgent'] == true
            ? Border.all(color: Color(0xFFE74C3C).withOpacity(0.3), width: 2)
            : null,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: taxDate['color'].withOpacity(0.2),
            child: Icon(taxDate['icon'], color: taxDate['color'], size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      taxDate['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    if (taxDate['isUrgent'] == true) ...[
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Urgent',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFFE74C3C),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  taxDate['description'],
                  style: TextStyle(fontSize: 14, color: Color(0xFF8A94A6)),
                ),
                SizedBox(height: 4),
                Text(
                  taxDate['date'],
                  style: TextStyle(
                    fontSize: 12,
                    color: taxDate['isUrgent'] == true
                        ? Color(0xFFE74C3C)
                        : Color(0xFF8A94A6),
                    fontWeight: taxDate['isUrgent'] == true
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Color(0xFF8A94A6), size: 16),
        ],
      ),
    ),
  );
}

Widget _taxTip(String tip) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 16),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            tip,
            style: TextStyle(fontSize: 14, color: Color(0xFF2E7D32)),
          ),
        ),
      ],
    ),
  );
}

void _showCalculateTaxDialog() {
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController expensesController = TextEditingController();

  Get.dialog(
    AlertDialog(
      title: Text('Calculate Tax Estimate'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: incomeController,
            decoration: InputDecoration(
              labelText: 'Annual Income',
              border: OutlineInputBorder(),
              prefixText: '\$',
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          TextField(
            controller: expensesController,
            decoration: InputDecoration(
              labelText: 'Business Expenses',
              border: OutlineInputBorder(),
              prefixText: '\$',
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'State',
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(value: 'CA', child: Text('California')),
              DropdownMenuItem(value: 'NY', child: Text('New York')),
              DropdownMenuItem(value: 'TX', child: Text('Texas')),
              DropdownMenuItem(value: 'FL', child: Text('Florida')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            onChanged: (value) {},
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (incomeController.text.isNotEmpty) {
              Get.back();
              Get.snackbar(
                'Tax Estimate Calculated',
                'Your estimated tax has been calculated and updated!',
                backgroundColor: Color(0xFF4CAF50),
                colorText: Colors.white,
              );
            }
          },
          child: Text('Calculate'),
        ),
      ],
    ),
  );
}

void _showTaxDateDetails(Map taxDate) {
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
                radius: 24,
                backgroundColor: taxDate['color'].withOpacity(0.2),
                child: Icon(taxDate['icon'], color: taxDate['color'], size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taxDate['title'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    Text(
                      taxDate['date'],
                      style: TextStyle(
                        fontSize: 16,
                        color: taxDate['isUrgent'] == true
                            ? Color(0xFFE74C3C)
                            : Color(0xFF8A94A6),
                        fontWeight: taxDate['isUrgent'] == true
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            taxDate['description'],
            style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
          ),
          SizedBox(height: 20),
          if (taxDate['isUrgent'] == true) ...[
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFE74C3C).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Color(0xFFE74C3C), size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This deadline is approaching soon. Make sure to file on time to avoid penalties.',
                      style: TextStyle(fontSize: 14, color: Color(0xFFE74C3C)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      'Info',
                      'Set reminder functionality will be implemented here',
                      backgroundColor: Color(0xFF2196F3),
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2196F3),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Set Reminder'),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      'Info',
                      'Learn more functionality will be implemented here',
                      backgroundColor: Color(0xFF4CAF50),
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4CAF50),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Learn More'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
