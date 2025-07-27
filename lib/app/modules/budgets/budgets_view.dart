import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class BudgetsView extends StatelessWidget {
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
          'Budget Plans',
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
              onTap: () => _showCreateBudgetDialog(),
              child: CircleAvatar(
                backgroundColor: Color(0xFF9C27B0),
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
                            'Total Budget',
                            '\$3,500',
                            Icons.account_balance_wallet,
                            Color(0xFF9C27B0),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            'Spent',
                            '\$2,150',
                            Icons.trending_down,
                            Color(0xFFE74C3C),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            'Remaining',
                            '\$1,350',
                            Icons.trending_up,
                            Color(0xFF4CAF50),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Progress Overview
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
                            'Monthly Overview',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF181F2B),
                            ),
                          ),
                          SizedBox(height: 12),
                          LinearProgressIndicator(
                            value: 0.61, // 2150/3500
                            backgroundColor: Color(0xFFE0E0E0),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF9C27B0),
                            ),
                            minHeight: 8,
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '61% of budget used',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF8A94A6),
                                ),
                              ),
                              Text(
                                '\$2,150 / \$3,500',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF8A94A6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    // Budget Categories
                    Text(
                      'Budget Categories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 400 ? 16 : 18,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    SizedBox(height: 12),

                    // Sample Budget Items
                    _budgetCard({
                      'category': 'Food & Dining',
                      'budget': 500.00,
                      'spent': 320.00,
                      'icon': Icons.restaurant,
                      'color': Color(0xFFFF5722),
                    }, size),
                    _budgetCard({
                      'category': 'Transportation',
                      'budget': 300.00,
                      'spent': 280.00,
                      'icon': Icons.directions_car,
                      'color': Color(0xFF2196F3),
                    }, size),
                    _budgetCard({
                      'category': 'Entertainment',
                      'budget': 200.00,
                      'spent': 150.00,
                      'icon': Icons.movie,
                      'color': Color(0xFF9C27B0),
                    }, size),
                    _budgetCard({
                      'category': 'Shopping',
                      'budget': 400.00,
                      'spent': 380.00,
                      'icon': Icons.shopping_bag,
                      'color': Color(0xFF4CAF50),
                    }, size),
                    _budgetCard({
                      'category': 'Utilities',
                      'budget': 250.00,
                      'spent': 180.00,
                      'icon': Icons.power,
                      'color': Color(0xFFFF9800),
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

Widget _budgetCard(Map budget, Size size) {
  final percentage = budget['spent'] / budget['budget'];
  final isOverBudget = percentage > 1.0;
  final isNearLimit = percentage > 0.8;

  Color progressColor;
  if (isOverBudget) {
    progressColor = Color(0xFFE74C3C);
  } else if (isNearLimit) {
    progressColor = Color(0xFFFF9800);
  } else {
    progressColor = budget['color'];
  }

  return GestureDetector(
    onTap: () => _showBudgetDetails(budget),
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
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: budget['color'].withOpacity(0.2),
                child: Icon(budget['icon'], color: budget['color'], size: 20),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      budget['category'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '\$${budget['spent'].toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8A94A6),
                          ),
                        ),
                        Text(
                          ' / \$${budget['budget'].toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8A94A6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${(percentage * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: progressColor,
                    ),
                  ),
                  if (isOverBudget)
                    Text(
                      'Over Budget',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFE74C3C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          LinearProgressIndicator(
            value: percentage > 1.0 ? 1.0 : percentage,
            backgroundColor: Color(0xFFE0E0E0),
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            minHeight: 6,
          ),
        ],
      ),
    ),
  );
}

void _showCreateBudgetDialog() {
  Get.dialog(
    AlertDialog(
      title: Text('Create New Budget'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Category Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Budget Amount',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Period',
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(value: 'Monthly', child: Text('Monthly')),
              DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
              DropdownMenuItem(value: 'Yearly', child: Text('Yearly')),
            ],
            onChanged: (value) {},
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Description (Optional)',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
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
              'Budget created successfully!',
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

void _showBudgetDetails(Map budget) {
  final percentage = budget['spent'] / budget['budget'];
  final isOverBudget = percentage > 1.0;
  final isNearLimit = percentage > 0.8;

  Color progressColor;
  if (isOverBudget) {
    progressColor = Color(0xFFE74C3C);
  } else if (isNearLimit) {
    progressColor = Color(0xFFFF9800);
  } else {
    progressColor = budget['color'];
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
                radius: 24,
                backgroundColor: budget['color'].withOpacity(0.2),
                child: Icon(budget['icon'], color: budget['color'], size: 24),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      budget['category'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    Text(
                      'Budget Category',
                      style: TextStyle(fontSize: 14, color: Color(0xFF8A94A6)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Budget:',
                      style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
                    ),
                    Text(
                      '\$${budget['budget'].toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Spent:',
                      style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
                    ),
                    Text(
                      '\$${budget['spent'].toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: progressColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Remaining:',
                      style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
                    ),
                    Text(
                      '\$${(budget['budget'] - budget['spent']).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          LinearProgressIndicator(
            value: percentage > 1.0 ? 1.0 : percentage,
            backgroundColor: Color(0xFFE0E0E0),
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            minHeight: 8,
          ),
          SizedBox(height: 8),
          Text(
            '${(percentage * 100).toStringAsFixed(0)}% of budget used',
            style: TextStyle(fontSize: 14, color: Color(0xFF8A94A6)),
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
                      'Edit budget functionality will be implemented here',
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
                      'View transactions functionality will be implemented here',
                      backgroundColor: Color(0xFF9C27B0),
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9C27B0),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('View Transactions'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
