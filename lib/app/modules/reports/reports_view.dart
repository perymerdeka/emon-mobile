import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'reports_controller.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class ReportsView extends GetView<ReportsController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.04 > 24 ? 24.0 : size.width * 0.04;
    final maxContentWidth = 500.0;
    RxInt tabIndex = 0.obs;
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
        title: const Text(
          'Reports',
          style: TextStyle(
            color: Color(0xFF181F2B),
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 18,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _tabButton('Monthly', 0, tabIndex),
                        _tabButton('Yearly', 1, tabIndex),
                        _tabButton('Custom', 2, tabIndex),
                      ],
                    ),
                    SizedBox(height: 18),
                    _incomeExpenseCard(context),
                    SizedBox(height: 24),
                    _breakdownCard(context),
                    SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.ios_share, color: Colors.white),
                        label: Text(
                          'Export & Share',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6366F1),
                          padding: EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
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
        currentIndex: 2,
        selectedItemColor: Color(0xFF6366F1),
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

Widget _tabButton(String label, int idx, RxInt tabIndex) {
  return Expanded(
    child: Obx(
      () => GestureDetector(
        onTap: () => tabIndex.value = idx,
        child: Container(
          margin: EdgeInsets.only(right: idx < 2 ? 8 : 0),
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: tabIndex.value == idx
                ? Color(0xFFEDEBFF)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            boxShadow: tabIndex.value == idx
                ? [
                    BoxShadow(
                      color: Color(0xFF6366F1).withValues(alpha: 0.12),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: tabIndex.value == idx
                    ? Color(0xFF6366F1)
                    : Color(0xFF8A94A6),
                fontWeight: tabIndex.value == idx
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _incomeExpenseCard(BuildContext context) {
  final controller = Get.find<ReportsController>();
  final maxVal = (controller.incomeData + controller.expenseData).reduce(
    (a, b) => a > b ? a : b,
  );
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Income vs Expenses',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF181F2B),
              ),
            ),
            SizedBox(width: 10),
            _dot(Color(0xFF10B981)),
            SizedBox(width: 4),
            Text('Income', style: TextStyle(color: Color(0xFF8A94A6))),
            SizedBox(width: 10),
            _dot(Color(0xFFF59E42)),
            SizedBox(width: 4),
            Text('Expenses', style: TextStyle(color: Color(0xFF8A94A6))),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(controller.months.length, (i) {
              final income = controller.incomeData[i];
              final expense = controller.expenseData[i];
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            height: maxVal == 0 ? 0 : 100 * (income / maxVal),
                            decoration: BoxDecoration(
                              color: Color(0xFF10B981),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Container(
                            height: maxVal == 0 ? 0 : 100 * (expense / maxVal),
                            decoration: BoxDecoration(
                              color: Color(0xFFF59E42),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      controller.months[i],
                      style: TextStyle(fontSize: 14, color: Color(0xFF181F2B)),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    ),
  );
}

Widget _dot(Color color) {
  return Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

Widget _breakdownCard(BuildContext context) {
  final controller = Get.find<ReportsController>();
  final total = controller.breakdown.fold<double>(
    0,
    (sum, item) => sum + (item['value'] as double),
  );
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category Breakdown',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF181F2B),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: CustomPaint(
                painter: _DonutChartPainter(controller.breakdown),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' ${total.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFF181F2B),
                        ),
                      ),
                      Text(
                        'Total Spent',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8A94A6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(controller.breakdown.length, (i) {
                  final item = controller.breakdown[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        _dot(item['color'] as Color),
                        SizedBox(width: 8),
                        Text(
                          item['label'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF181F2B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _DonutChartPainter extends CustomPainter {
  final List breakdown;
  _DonutChartPainter(this.breakdown);
  @override
  void paint(Canvas canvas, Size size) {
    double total = breakdown.fold<double>(
      0,
      (sum, item) => sum + (item['value'] as double),
    );
    double start = -3.14 / 2;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final stroke = size.width * 0.18;
    for (var item in breakdown) {
      final sweep = (item['value'] as double) / total * 3.14 * 2;
      final paint = Paint()
        ..color = item['color'] as Color
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(rect, start, sweep, false, paint);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
