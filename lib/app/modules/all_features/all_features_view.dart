import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllFeaturesView extends StatelessWidget {
  final List<_FeatureSection> sections = [
    _FeatureSection(
      title: 'Money',
      features: [
        _FeatureItem('Cards', Icons.credit_card, Color(0xFFB3E5FC)),
        _FeatureItem('Invoices', Icons.attach_money, Color(0xFFB3E5FC)),
        _FeatureItem('Bills', Icons.receipt_long, Color(0xFFB3E5FC)),
        _FeatureItem('Transactions', Icons.swap_horiz, Color(0xFFB3E5FC)),
        _FeatureItem('Checks', Icons.mail_outline, Color(0xFFB3E5FC)),
        _FeatureItem(
          'Cash',
          Icons.account_balance_wallet_outlined,
          Color(0xFFB3E5FC),
        ),
      ],
    ),
    _FeatureSection(
      title: 'Taxes',
      features: [
        _FeatureItem(
          'Tax Estimates',
          Icons.insert_drive_file_outlined,
          Color(0xFFB3B7F6),
        ),
        _FeatureItem(
          'Tax Filing',
          Icons.insert_drive_file_outlined,
          Color(0xFFB3B7F6),
        ),
        _FeatureItem(
          'Tax History',
          Icons.insert_drive_file_outlined,
          Color(0xFFB3B7F6),
        ),
      ],
    ),
    _FeatureSection(
      title: 'Benefits',
      features: [
        _FeatureItem(
          'Health Insurance',
          Icons.local_hospital,
          Color(0xFFB2F2D7),
        ),
        _FeatureItem(
          'Retirement',
          Icons.emoji_events_outlined,
          Color(0xFFB2F2D7),
        ),
        _FeatureItem('Other Benefits', Icons.work_outline, Color(0xFFB2F2D7)),
      ],
    ),
    _FeatureSection(
      title: 'Business',
      features: [
        _FeatureItem('Clients', Icons.groups_outlined, Color(0xFFFFF9C4)),
        _FeatureItem('Team', Icons.groups, Color(0xFFFFF9C4)),
        _FeatureItem('Payroll', Icons.account_balance, Color(0xFFFFF9C4)),
      ],
    ),
    _FeatureSection(
      title: 'More',
      features: [
        _FeatureItem('Settings', Icons.settings, Color(0xFFE1BEE7)),
        _FeatureItem('Help Center', Icons.help_outline, Color(0xFFE1BEE7)),
        _FeatureItem('Consultation', Icons.info_outline, Color(0xFFE1BEE7)),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            fontSize: 22,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        itemCount: sections.length,
        itemBuilder: (context, idx) {
          final section = sections[idx];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: idx == 0 ? 0 : 18),
              Text(
                section.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF181F2B),
                ),
              ),
              SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 2.5,
                children: section.features
                    .map((f) => _featureCard(f, size))
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _featureCard(_FeatureItem f, Size size) {
  return GestureDetector(
    onTap: () {
      if (f.label == 'Consultation') {
        Get.toNamed('/ai-consultation');
      }
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircleAvatar(
              backgroundColor: f.color.withOpacity(0.25),
              radius: 22,
              child: Icon(f.icon, color: f.color, size: 26),
            ),
          ),
          Expanded(
            child: Text(
              f.label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF181F2B),
              ),
            ),
          ),
        ],
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
  _FeatureItem(this.label, this.icon, this.color);
}
