import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class HelpView extends StatelessWidget {
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
          'Help Center',
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
              onTap: () => _showContactSupportDialog(),
              child: CircleAvatar(
                backgroundColor: Color(0xFF2196F3),
                child: Icon(Icons.support_agent, color: Colors.white),
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
                    // Search Bar
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
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
                          Icon(Icons.search, color: Color(0xFF8A94A6)),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for help...',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Color(0xFF8A94A6)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    // Quick Help Categories
                    Text(
                      'Quick Help',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 400 ? 16 : 18,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _quickHelpCard(
                            'Getting Started',
                            Icons.rocket_launch,
                            Color(0xFF2196F3),
                            () => _showGettingStartedHelp(),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _quickHelpCard(
                            'Account Setup',
                            Icons.person_add,
                            Color(0xFF4CAF50),
                            () => _showAccountSetupHelp(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _quickHelpCard(
                            'Transactions',
                            Icons.swap_horiz,
                            Color(0xFFFF9800),
                            () => _showTransactionsHelp(),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _quickHelpCard(
                            'Security',
                            Icons.security,
                            Color(0xFFE74C3C),
                            () => _showSecurityHelp(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // FAQ Section
                    Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 400 ? 16 : 18,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    SizedBox(height: 12),

                    _faqCard({
                      'question': 'How do I add a new transaction?',
                      'answer':
                          'Go to the Transactions tab and tap the + button. Fill in the amount, description, category, and date, then tap Save.',
                      'category': 'Transactions',
                    }, size),
                    _faqCard({
                      'question': 'How do I connect my bank account?',
                      'answer':
                          'Go to Accounts tab, tap the + button, and follow the secure connection process with your bank.',
                      'category': 'Accounts',
                    }, size),
                    _faqCard({
                      'question': 'How do I create a budget?',
                      'answer':
                          'Go to Budget Plans, tap the + button, set your category, amount, and period, then tap Create.',
                      'category': 'Budgeting',
                    }, size),
                    _faqCard({
                      'question': 'How do I set up savings goals?',
                      'answer':
                          'Go to Savings Goals, tap the + button, set your goal name, target amount, and deadline, then tap Create.',
                      'category': 'Savings',
                    }, size),

                    SizedBox(height: 24),

                    // Contact Support
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
                            'Still Need Help?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF181F2B),
                            ),
                          ),
                          SizedBox(height: 12),
                          _contactOption(
                            'Email Support',
                            'support@emon.com',
                            Icons.email,
                            Color(0xFF2196F3),
                            () => _contactEmail(),
                          ),
                          SizedBox(height: 8),
                          _contactOption(
                            'Live Chat',
                            'Available 24/7',
                            Icons.chat,
                            Color(0xFF4CAF50),
                            () => _startLiveChat(),
                          ),
                          SizedBox(height: 8),
                          _contactOption(
                            'Phone Support',
                            '+1 (555) 123-4567',
                            Icons.phone,
                            Color(0xFFFF9800),
                            () => _callSupport(),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // App Info
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Emon - Personal Finance Manager',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF181F2B),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Version 1.0.0',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8A94A6),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _appInfoButton(
                                'Privacy Policy',
                                () => _showPrivacyPolicy(),
                              ),
                              _appInfoButton(
                                'Terms of Service',
                                () => _showTermsOfService(),
                              ),
                              _appInfoButton('About', () => _showAbout()),
                            ],
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

Widget _quickHelpCard(
  String title,
  IconData icon,
  Color color,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
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
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF181F2B),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget _faqCard(Map faq, Size size) {
  return GestureDetector(
    onTap: () => _showFaqDetails(faq),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  faq['question'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF181F2B),
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Color(0xFF8A94A6), size: 16),
            ],
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              faq['category'],
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF1976D2),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _contactOption(
  String title,
  String subtitle,
  IconData icon,
  Color color,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF181F2B),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Color(0xFF8A94A6)),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: color, size: 16),
        ],
      ),
    ),
  );
}

Widget _appInfoButton(String title, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Text(
      title,
      style: TextStyle(
        fontSize: 12,
        color: Color(0xFF2196F3),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

void _showContactSupportDialog() {
  Get.dialog(
    AlertDialog(
      title: Text('Contact Support'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('How can we help you today?', style: TextStyle(fontSize: 16)),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Subject',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            Get.back();
            Get.snackbar(
              'Message Sent',
              'Your support request has been sent successfully!',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          },
          child: Text('Send'),
        ),
      ],
    ),
  );
}

void _showGettingStartedHelp() {
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
                backgroundColor: Color(0xFF2196F3).withOpacity(0.2),
                child: Icon(
                  Icons.rocket_launch,
                  color: Color(0xFF2196F3),
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Text(
                'Getting Started',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF181F2B),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _helpStep('1', 'Create your account and complete profile setup'),
          _helpStep(
            '2',
            'Connect your bank accounts for automatic transaction sync',
          ),
          _helpStep(
            '3',
            'Add your first transaction manually or import from bank',
          ),
          _helpStep('4', 'Set up your first budget and savings goals'),
          _helpStep('5', 'Explore AI consultation for financial advice'),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2196F3),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('Got it!'),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _helpStep(String number, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Color(0xFF2196F3),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 14, color: Color(0xFF181F2B)),
          ),
        ),
      ],
    ),
  );
}

void _showAccountSetupHelp() {
  Get.snackbar(
    'Account Setup Help',
    'Account setup guide will be shown here',
    backgroundColor: Color(0xFF4CAF50),
    colorText: Colors.white,
  );
}

void _showTransactionsHelp() {
  Get.snackbar(
    'Transactions Help',
    'Transactions guide will be shown here',
    backgroundColor: Color(0xFFFF9800),
    colorText: Colors.white,
  );
}

void _showSecurityHelp() {
  Get.snackbar(
    'Security Help',
    'Security guide will be shown here',
    backgroundColor: Color(0xFFE74C3C),
    colorText: Colors.white,
  );
}

void _showFaqDetails(Map faq) {
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
            faq['question'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF181F2B),
            ),
          ),
          SizedBox(height: 16),
          Text(
            faq['answer'],
            style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              faq['category'],
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF1976D2),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      'Feedback',
                      'Thank you for your feedback!',
                      backgroundColor: Color(0xFF4CAF50),
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4CAF50),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Helpful'),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    _showContactSupportDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2196F3),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Need More Help'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

void _contactEmail() {
  Get.snackbar(
    'Email Support',
    'Opening email client...',
    backgroundColor: Color(0xFF2196F3),
    colorText: Colors.white,
  );
}

void _startLiveChat() {
  Get.snackbar(
    'Live Chat',
    'Connecting to live chat...',
    backgroundColor: Color(0xFF4CAF50),
    colorText: Colors.white,
  );
}

void _callSupport() {
  Get.snackbar(
    'Phone Support',
    'Opening phone dialer...',
    backgroundColor: Color(0xFFFF9800),
    colorText: Colors.white,
  );
}

void _showPrivacyPolicy() {
  Get.snackbar(
    'Privacy Policy',
    'Privacy policy will be shown here',
    backgroundColor: Color(0xFF9C27B0),
    colorText: Colors.white,
  );
}

void _showTermsOfService() {
  Get.snackbar(
    'Terms of Service',
    'Terms of service will be shown here',
    backgroundColor: Color(0xFF607D8B),
    colorText: Colors.white,
  );
}

void _showAbout() {
  Get.snackbar(
    'About Emon',
    'About information will be shown here',
    backgroundColor: Color(0xFF795548),
    colorText: Colors.white,
  );
}
