import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class AccountsView extends StatelessWidget {
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
          'Bank Accounts',
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
              onTap: () => _showAddAccountDialog(),
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
                            'Total Balance',
                            '\$12,450',
                            Icons.account_balance_wallet,
                            Color(0xFF4CAF50),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            'Connected',
                            '3',
                            Icons.link,
                            Color(0xFF2196F3),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            'Last Sync',
                            '2h ago',
                            Icons.sync,
                            Color(0xFF9C27B0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Quick Actions
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
                            'Quick Actions',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF181F2B),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _quickActionButton(
                                  'Sync All',
                                  Icons.sync,
                                  Color(0xFF2196F3),
                                  () => _syncAllAccounts(),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: _quickActionButton(
                                  'Transfer',
                                  Icons.swap_horiz,
                                  Color(0xFF4CAF50),
                                  () => _showTransferDialog(),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: _quickActionButton(
                                  'Export',
                                  Icons.download,
                                  Color(0xFFFF9800),
                                  () => _exportAccounts(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    // Accounts List
                    Text(
                      'Connected Accounts',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 400 ? 16 : 18,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    SizedBox(height: 12),

                    // Sample Accounts
                    _accountCard({
                      'name': 'Chase Bank',
                      'accountNumber': '****1234',
                      'balance': 8500.00,
                      'type': 'Checking',
                      'icon': Icons.account_balance,
                      'color': Color(0xFF2196F3),
                      'isConnected': true,
                      'lastTransaction': '2 hours ago',
                    }, size),
                    _accountCard({
                      'name': 'Wells Fargo',
                      'accountNumber': '****5678',
                      'balance': 3200.00,
                      'type': 'Savings',
                      'icon': Icons.savings,
                      'color': Color(0xFF4CAF50),
                      'isConnected': true,
                      'lastTransaction': '1 day ago',
                    }, size),
                    _accountCard({
                      'name': 'Bank of America',
                      'accountNumber': '****9012',
                      'balance': 750.00,
                      'type': 'Credit Card',
                      'icon': Icons.credit_card,
                      'color': Color(0xFFE74C3C),
                      'isConnected': true,
                      'lastTransaction': '3 days ago',
                    }, size),

                    SizedBox(height: 24),

                    // Disconnected Accounts
                    Text(
                      'Available Banks',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width < 400 ? 16 : 18,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    SizedBox(height: 12),

                    _availableBankCard({
                      'name': 'Citibank',
                      'description': 'Connect your Citibank account',
                      'icon': Icons.account_balance,
                      'color': Color(0xFF9C27B0),
                    }, size),
                    _availableBankCard({
                      'name': 'American Express',
                      'description': 'Connect your Amex account',
                      'icon': Icons.credit_card,
                      'color': Color(0xFF607D8B),
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

Widget _quickActionButton(
  String title,
  IconData icon,
  Color color,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget _accountCard(Map account, Size size) {
  return GestureDetector(
    onTap: () => _showAccountDetails(account),
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
            backgroundColor: account['color'].withOpacity(0.2),
            child: Icon(account['icon'], color: account['color'], size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      account['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8F5E8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Connected',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF4CAF50),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  '${account['type']} • ${account['accountNumber']}',
                  style: TextStyle(fontSize: 14, color: Color(0xFF8A94A6)),
                ),
                SizedBox(height: 4),
                Text(
                  'Last transaction: ${account['lastTransaction']}',
                  style: TextStyle(fontSize: 12, color: Color(0xFF8A94A6)),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${account['balance'].toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF181F2B),
                ),
              ),
              SizedBox(height: 4),
              Icon(Icons.arrow_forward_ios, color: Color(0xFF8A94A6), size: 16),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _availableBankCard(Map bank, Size size) {
  return GestureDetector(
    onTap: () => _connectBank(bank),
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
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: bank['color'].withOpacity(0.2),
            child: Icon(bank['icon'], color: bank['color'], size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bank['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF181F2B),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  bank['description'],
                  style: TextStyle(fontSize: 14, color: Color(0xFF8A94A6)),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Connect',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void _showAddAccountDialog() {
  Get.dialog(
    AlertDialog(
      title: Text('Add Bank Account'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Bank Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Account Number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Account Type',
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(value: 'Checking', child: Text('Checking')),
              DropdownMenuItem(value: 'Savings', child: Text('Savings')),
              DropdownMenuItem(
                value: 'Credit Card',
                child: Text('Credit Card'),
              ),
            ],
            onChanged: (value) {},
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
              'Bank account added successfully!',
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

void _showAccountDetails(Map account) {
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
                radius: 28,
                backgroundColor: account['color'].withOpacity(0.2),
                child: Icon(account['icon'], color: account['color'], size: 28),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account['name'],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF181F2B),
                      ),
                    ),
                    Text(
                      account['type'],
                      style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
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
                      'Account Number:',
                      style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
                    ),
                    Text(
                      account['accountNumber'],
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
                      'Current Balance:',
                      style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
                    ),
                    Text(
                      '\$${account['balance'].toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Last Sync:',
                      style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
                    ),
                    Text(
                      account['lastTransaction'],
                      style: TextStyle(fontSize: 16, color: Color(0xFF181F2B)),
                    ),
                  ],
                ),
              ],
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
                      'Info',
                      'Sync account functionality will be implemented here',
                      backgroundColor: Color(0xFF2196F3),
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2196F3),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Sync Now'),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      'Info',
                      'Disconnect functionality will be implemented here',
                      backgroundColor: Color(0xFFE74C3C),
                      colorText: Colors.white,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE74C3C),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Disconnect'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

void _syncAllAccounts() {
  Get.snackbar(
    'Syncing',
    'Syncing all connected accounts...',
    backgroundColor: Color(0xFF2196F3),
    colorText: Colors.white,
  );
}

void _showTransferDialog() {
  Get.dialog(
    AlertDialog(
      title: Text('Transfer Between Accounts'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'From Account',
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(value: 'Chase', child: Text('Chase Bank')),
              DropdownMenuItem(value: 'Wells', child: Text('Wells Fargo')),
              DropdownMenuItem(value: 'BOA', child: Text('Bank of America')),
            ],
            onChanged: (value) {},
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'To Account',
              border: OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(value: 'Chase', child: Text('Chase Bank')),
              DropdownMenuItem(value: 'Wells', child: Text('Wells Fargo')),
              DropdownMenuItem(value: 'BOA', child: Text('Bank of America')),
            ],
            onChanged: (value) {},
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
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
            Get.back();
            Get.snackbar(
              'Success',
              'Transfer initiated successfully!',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          },
          child: Text('Transfer'),
        ),
      ],
    ),
  );
}

void _exportAccounts() {
  Get.snackbar(
    'Exporting',
    'Exporting account data...',
    backgroundColor: Color(0xFFFF9800),
    colorText: Colors.white,
  );
}

void _connectBank(Map bank) {
  Get.dialog(
    AlertDialog(
      title: Text('Connect ${bank['name']}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You will be redirected to ${bank['name']} to securely connect your account.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.security, color: Color(0xFF2196F3), size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Your banking credentials are never stored and all connections are encrypted.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF1976D2)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            Get.back();
            Get.snackbar(
              'Connecting',
              'Connecting to ${bank['name']}...',
              backgroundColor: Color(0xFF4CAF50),
              colorText: Colors.white,
            );
          },
          child: Text('Connect'),
        ),
      ],
    ),
  );
}
