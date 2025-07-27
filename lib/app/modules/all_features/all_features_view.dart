import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class AllFeaturesView extends StatelessWidget {
  final List<_FeatureSection> sections = [
    _FeatureSection(
      title: 'Transaction Management',
      features: [
        _FeatureItem(
          'Transactions',
          Icons.swap_horiz,
          Color(0xFFB3E5FC),
          'Track your income and expenses.',
        ),
        _FeatureItem(
          'Invoices',
          Icons.attach_money,
          Color(0xFFB3E5FC),
          'Create and send professional invoices.',
        ),
        _FeatureItem(
          'Bills',
          Icons.receipt_long,
          Color(0xFFB3E5FC),
          'Manage and pay your bills on time.',
        ),
      ],
    ),
    _FeatureSection(
      title: 'Budgeting',
      features: [
        _FeatureItem(
          'Budget Plans',
          Icons.cloud_outlined,
          Color(0xFFF8BBD9),
          'Create budgets to manage your spending.',
        ),
        _FeatureItem(
          'Savings Goals',
          Icons.savings_outlined,
          Color(0xFFF8BBD9),
          'Set and track your financial goals.',
        ),
      ],
    ),
    _FeatureSection(
      title: 'Reporting',
      features: [
        _FeatureItem(
          'Tax Estimates',
          Icons.description_outlined,
          Color(0xFFFFCC80),
          'Estimate your freelance tax obligations.',
        ),
        _FeatureItem(
          'Expense Reports',
          Icons.bar_chart_outlined,
          Color(0xFFFFCC80),
          'Generate reports for business expenses.',
        ),
      ],
    ),
    _FeatureSection(
      title: 'User Settings',
      features: [
        _FeatureItem(
          'Settings',
          Icons.settings,
          Color(0xFFE1BEE7),
          'Customize your app experience.',
        ),
        _FeatureItem(
          'Accounts',
          Icons.mail_outline,
          Color(0xFFE1BEE7),
          'Manage your connected bank accounts.',
        ),
        _FeatureItem(
          'Help Center',
          Icons.help_outline,
          Color(0xFFE1BEE7),
          'Get support and find answers.',
        ),
      ],
    ),
  ];

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
          'All Features',
          style: TextStyle(
            color: Color(0xFF181F2B),
            fontWeight: FontWeight.bold,
            fontSize: size.width < 400 ? 20 : 22,
          ),
        ),
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
                  children: [
                    // AI Consultation Section
                    _buildAIConsultationCard(size),
                    SizedBox(height: 24),

                    // Feature Sections
                    ...sections.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final section = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: idx == 0 ? 0 : 24),
                          Text(
                            section.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width < 400 ? 16 : 18,
                              color: Color(0xFF181F2B),
                            ),
                          ),
                          SizedBox(height: 12),
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.4,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: section.features.length,
                            itemBuilder: (context, featureIdx) {
                              return _featureCard(
                                section.features[featureIdx],
                                size,
                              );
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAIConsultationCard(Size size) {
    return Container(
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
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFF2196F3).withOpacity(0.2),
            radius: size.width < 400 ? 24 : 28,
            child: Icon(
              Icons.auto_awesome,
              color: Color(0xFF2196F3),
              size: size.width < 400 ? 24 : 28,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Consultation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width < 400 ? 16 : 18,
                    color: Color(0xFF181F2B),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Get financial advice powered by AI.',
                  style: TextStyle(
                    fontSize: size.width < 400 ? 12 : 14,
                    color: Color(0xFF8A94A6),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.AI_CONSULTATION),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2196F3),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Get Started',
              style: TextStyle(
                fontSize: size.width < 400 ? 12 : 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _featureCard(_FeatureItem f, Size size) {
  return GestureDetector(
    onTap: () {
      // Handle navigation based on feature
      switch (f.label) {
        case 'Transactions':
          Get.toNamed(Routes.TRANSACTIONS);
          break;
        case 'Invoices':
          Get.toNamed(Routes.INVOICES);
          break;
        case 'Bills':
          Get.toNamed(Routes.BILLS);
          break;
        case 'Budget Plans':
          Get.toNamed(Routes.BUDGETS);
          break;
        case 'Savings Goals':
          Get.toNamed(Routes.SAVINGS);
          break;
        case 'Tax Estimates':
          Get.toNamed(Routes.TAX_ESTIMATES);
          break;
        case 'Expense Reports':
          Get.toNamed(Routes.REPORTS);
          break;
        case 'Settings':
          Get.toNamed(Routes.PROFILE);
          break;
        case 'Accounts':
          Get.toNamed(Routes.ACCOUNTS);
          break;
        case 'Help Center':
          Get.toNamed(Routes.HELP);
          break;
      }
    },
    child: Container(
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
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: f.color.withOpacity(0.2),
              radius: size.width < 400 ? 20 : 24,
              child: Icon(
                f.icon,
                color: f.color,
                size: size.width < 400 ? 20 : 24,
              ),
            ),
            SizedBox(height: 8),
            Flexible(
              child: Text(
                f.label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width < 400 ? 13 : 15,
                  color: Color(0xFF181F2B),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 2),
            Flexible(
              child: Text(
                f.description,
                style: TextStyle(
                  fontSize: size.width < 400 ? 10 : 11,
                  color: Color(0xFF8A94A6),
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _FeatureSection {
  final String title;
  final List<_FeatureItem> features;
  _FeatureSection({required this.title, required this.features});
}

class _FeatureItem {
  final String label;
  final IconData icon;
  final Color color;
  final String description;
  _FeatureItem(this.label, this.icon, this.color, this.description);
}


