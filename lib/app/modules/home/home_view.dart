import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.04 > 32 ? 32.0 : size.width * 0.04;
    final maxContentWidth = 500.0;

    final income = 3456.78;
    final expenses = 2100.00;
    final maxBarOverall = income > expenses ? income : expenses;
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: const Color(0xFF181F2B),
            fontWeight: FontWeight.bold,
            fontSize: size.width < 400 ? 20 : 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFF2F6FA),
              child: Icon(
                Icons.settings,
                color: const Color(0xFF181F2B),
                size: size.width < 400 ? 20 : 24,
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
                    Text(
                      'Overview',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 400 ? 16 : 20,
                        color: const Color(0xFF181F2B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(size.width < 400 ? 12 : 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F0FF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Balance',
                                  style: TextStyle(
                                    color: const Color(0xFF8A94A6),
                                    fontSize: size.width < 400 ? 12 : 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  ' 2412,345.67',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width < 400 ? 20 : 28,
                                    color: const Color(0xFF181F2B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '+4.8%',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width < 400 ? 12 : 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  size.width < 400 ? 10 : 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Net Change',
                                      style: TextStyle(
                                        color: const Color(0xFF8A94A6),
                                        fontSize: size.width < 400 ? 10 : 14,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '+567.89',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width < 400 ? 12 : 16,
                                        color: const Color(0xFF181F2B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: EdgeInsets.all(
                                  size.width < 400 ? 10 : 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Top Category',
                                      style: TextStyle(
                                        color: const Color(0xFF8A94A6),
                                        fontSize: size.width < 400 ? 10 : 14,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Freelance',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width < 400 ? 12 : 16,
                                        color: const Color(0xFF181F2B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Monthly Summary',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 400 ? 16 : 20,
                        color: const Color(0xFF181F2B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(size.width < 400 ? 12 : 20),
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
                                  color: Color(0xFF8A94A6),
                                  fontSize: size.width < 400 ? 12 : 16,
                                ),
                              ),
                              SizedBox(width: 8),
                              _LegendDot(color: Color(0xFF3498F3)),
                              SizedBox(width: 4),
                              Text(
                                'Income',
                                style: TextStyle(
                                  color: Color(0xFF181F2B),
                                  fontSize: size.width < 400 ? 12 : 14,
                                ),
                              ),
                              SizedBox(width: 8),
                              _LegendDot(color: Color(0xFFB3D6FF)),
                              SizedBox(width: 4),
                              Text(
                                'Expenses',
                                style: TextStyle(
                                  color: Color(0xFF8A94A6),
                                  fontSize: size.width < 400 ? 12 : 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\$${income.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width < 400 ? 28 : 36,
                              color: Color(0xFF181F2B),
                            ),
                          ),
                          Text(
                            'This Month',
                            style: TextStyle(
                              color: Color(0xFF8A94A6),
                              fontSize: size.width < 400 ? 12 : 16,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _bigBar(
                                'Income',
                                income,
                                maxBarOverall,
                                size,
                                true,
                              ),
                              _bigBar(
                                'Expenses',
                                expenses,
                                maxBarOverall,
                                size,
                                false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Budget Progress',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 400 ? 16 : 20,
                        color: const Color(0xFF181F2B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(size.width < 400 ? 12 : 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Groceries',
                                style: TextStyle(
                                  color: const Color(0xFF8A94A6),
                                  fontSize: size.width < 400 ? 12 : 16,
                                ),
                              ),
                              Text(
                                ' 24750 / 241000',
                                style: TextStyle(
                                  color: const Color(0xFF181F2B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width < 400 ? 12 : 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: 0.75,
                              minHeight: size.width < 400 ? 6 : 8,
                              backgroundColor: const Color(0xFFE3F0FF),
                              valueColor: const AlwaysStoppedAnimation(
                                Color(0xFF3498F3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3498F3),
                              padding: EdgeInsets.symmetric(
                                vertical: size.width < 400 ? 12 : 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Add Transaction',
                              style: TextStyle(
                                fontSize: size.width < 400 ? 14 : 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE3F0FF),
                              padding: EdgeInsets.symmetric(
                                vertical: size.width < 400 ? 12 : 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'View All',
                              style: TextStyle(
                                fontSize: size.width < 400 ? 14 : 16,
                                color: const Color(0xFF3498F3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF3498F3),
        unselectedItemColor: const Color(0xFF8A94A6),
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

class _LegendDot extends StatelessWidget {
  final Color color;
  const _LegendDot({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

Widget _bigBar(
  String label,
  double value,
  double maxBar,
  Size size,
  bool isIncome,
) {
  final barWidth = size.width < 400 ? 48.0 : 64.0;
  final barHeight = size.width < 400 ? 100.0 : 140.0;
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: barWidth,
        height: maxBar == 0 ? 0 : barHeight * (value / maxBar),
        decoration: BoxDecoration(
          gradient: isIncome
              ? LinearGradient(
                  colors: [Color(0xFF3498F3), Color(0xFFB3D6FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : LinearGradient(
                  colors: [Color(0xFFB3D6FF), Color(0xFFE3F0FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      SizedBox(height: 12),
      Text(
        label,
        style: TextStyle(
          fontSize: size.width < 400 ? 14 : 16,
          color: Color(0xFF181F2B),
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
