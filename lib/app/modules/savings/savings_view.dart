import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class SavingsView extends StatelessWidget {
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
          'Savings Goals',
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
              onTap: () => _showCreateGoalDialog(),
              child: CircleAvatar(
                backgroundColor: Color(0xFF4CAF50),
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
                            'Total Goals',
                            '5',
                            Icons.flag,
                            Color(0xFF4CAF50),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            'Total Saved',
                            '\$8,250',
                            Icons.savings,
                            Color(0xFF2196F3),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            'Completed',
                            '2',
                            Icons.check_circle,
                            Color(0xFF9C27B0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Overall Progress
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
                            'Overall Progress',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF181F2B),
                            ),
                          ),
                          SizedBox(height: 12),
                          LinearProgressIndicator(
                            value: 0.68, // 8250/12000
                            backgroundColor: Color(0xFFE0E0E0),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF4CAF50),
                            ),
                            minHeight: 8,
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '68% of total goals',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF8A94A6),
                                ),
                              ),
                              Text(
                                '\$8,250 / \$12,000',
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

                    // Goals List
                    Text(
                      'Your Goals',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 400 ? 16 : 18,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    SizedBox(height: 12),

                    // Sample Goals
                    _goalCard({
                      'title': 'Vacation Fund',
                      'target': 3000.00,
                      'saved': 2100.00,
                      'icon': Icons.flight,
                      'color': Color(0xFF2196F3),
                      'deadline': '2024-06-15',
                      'isCompleted': false,
                    }, size),
                    _goalCard({
                      'title': 'Emergency Fund',
                      'target': 5000.00,
                      'saved': 5000.00,
                      'icon': Icons.security,
                      'color': Color(0xFF4CAF50),
                      'deadline': '2024-03-01',
                      'isCompleted': true,
                    }, size),
                    _goalCard({
                      'title': 'New Laptop',
                      'target': 1500.00,
                      'saved': 800.00,
                      'icon': Icons.laptop,
                      'color': Color(0xFF9C27B0),
                      'deadline': '2024-05-20',
                      'isCompleted': false,
                    }, size),
                    _goalCard({
                      'title': 'Home Renovation',
                      'target': 2000.00,
                      'saved': 350.00,
                      'icon': Icons.home,
                      'color': Color(0xFFFF9800),
                      'deadline': '2024-08-30',
                      'isCompleted': false,
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

Widget _goalCard(Map goal, Size size) {
  final percentage = goal['saved'] / goal['target'];
  final isCompleted = goal['isCompleted'] == true;

  Color progressColor;
  if (isCompleted) {
    progressColor = Color(0xFF4CAF50);
  } else if (percentage > 0.8) {
    progressColor = Color(0xFF4CAF50);
  } else if (percentage > 0.5) {
    progressColor = Color(0xFFFF9800);
  } else {
    progressColor = Color(0xFFE74C3C);
  }

  return GestureDetector(
    onTap: () => _showGoalDetails(goal),
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
        border: isCompleted
            ? Border.all(color: Color(0xFF4CAF50).withOpacity(0.3), width: 2)
            : null,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: goal['color'].withOpacity(0.2),
                    child: Icon(goal['icon'], color: goal['color'], size: 24),
                  ),
                  if (isCompleted)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 12),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          goal['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF181F2B),
                          ),
                        ),
                        if (isCompleted) ...[
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFE8F5E8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Completed',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF4CAF50),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Target: \$${goal['target'].toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 14, color: Color(0xFF8A94A6)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Deadline: ${goal['deadline']}',
                      style: TextStyle(fontSize: 12, color: Color(0xFF8A94A6)),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${goal['saved'].toStringAsFixed(0)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF181F2B),
                    ),
                  ),
                  Text(
                    '${(percentage * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 14,
                      color: progressColor,
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

void _showCreateGoalDialog() {
  Get.dialog(
    AlertDialog(
      title: Text('Create New Goal'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Goal Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Target Amount',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Target Date',
              border: OutlineInputBorder(),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: Get.context!,
                initialDate: DateTime.now().add(Duration(days: 30)),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365 * 5)),
              );
              if (picked != null) {
                // Handle date selection
              }
            },
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(value: 'Travel', child: Text('Travel')),
              DropdownMenuItem(
                value: 'Electronics',
                child: Text('Electronics'),
              ),
              DropdownMenuItem(value: 'Home', child: Text('Home')),
              DropdownMenuItem(value: 'Education', child: Text('Education')),
              DropdownMenuItem(value: 'Emergency', child: Text('Emergency')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
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
              'Goal created successfully!',
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

void _showGoalDetails(Map goal) {
  final percentage = goal['saved'] / goal['target'];
  final isCompleted = goal['isCompleted'] == true;

  Color progressColor;
  if (isCompleted) {
    progressColor = Color(0xFF4CAF50);
  } else if (percentage > 0.8) {
    progressColor = Color(0xFF4CAF50);
  } else if (percentage > 0.5) {
    progressColor = Color(0xFFFF9800);
  } else {
    progressColor = Color(0xFFE74C3C);
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
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: goal['color'].withOpacity(0.2),
                    child: Icon(goal['icon'], color: goal['color'], size: 28),
                  ),
                  if (isCompleted)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 14),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal['title'],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    if (isCompleted)
                      Text(
                        'Goal Completed!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4CAF50),
                          fontWeight: FontWeight.w600,
                        ),
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
                      'Target:',
                      style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
                    ),
                    Text(
                      '\$${goal['target'].toStringAsFixed(2)}',
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
                      'Saved:',
                      style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
                    ),
                    Text(
                      '\$${goal['saved'].toStringAsFixed(2)}',
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
                      '\$${(goal['target'] - goal['saved']).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE74C3C),
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
            '${(percentage * 100).toStringAsFixed(0)}% completed',
            style: TextStyle(fontSize: 14, color: Color(0xFF8A94A6)),
          ),
          SizedBox(height: 20),
          if (!isCompleted) ...[
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      _showAddMoneyDialog(goal);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4CAF50),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text('Add Money'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.snackbar(
                        'Info',
                        'Edit goal functionality will be implemented here',
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
                    'Congratulations!',
                    'You have successfully completed this goal!',
                    backgroundColor: Color(0xFF4CAF50),
                    colorText: Colors.white,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Goal Completed!'),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}

void _showAddMoneyDialog(Map goal) {
  final TextEditingController amountController = TextEditingController();

  Get.dialog(
    AlertDialog(
      title: Text('Add Money to Goal'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            goal['title'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF181F2B),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: amountController,
            decoration: InputDecoration(
              labelText: 'Amount to Add',
              border: OutlineInputBorder(),
              prefixText: '\$',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (amountController.text.isNotEmpty) {
              Get.back();
              Get.snackbar(
                'Success',
                'Money added to goal successfully!',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            }
          },
          child: Text('Add'),
        ),
      ],
    ),
  );
}
