import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  final List<_NotificationItem> notifications = [
    _NotificationItem(
      icon: Icons.verified_user_outlined,
      iconBg: Color(0xFFE6F0FF),
      iconColor: Color(0xFF2563EB),
      title: 'Account Verified',
      desc: 'Your account is now verified. You can now access all features.',
    ),
    _NotificationItem(
      icon: Icons.attach_money,
      iconBg: Color(0xFFE6FCE6),
      iconColor: Color(0xFF27AE60),
      title: 'Payment Received',
      desc: 'Your payment of \$1500 has been successfully processed.',
    ),
    _NotificationItem(
      icon: Icons.insert_drive_file_outlined,
      iconBg: Color(0xFFF3E8FF),
      iconColor: Color(0xFF9B59B6),
      title: 'Report Available',
      desc: 'Your monthly report is ready for review.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFF181F2B),
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(
                  Icons.notifications_none,
                  color: Color(0xFF181F2B),
                  size: 30,
                ),
                Positioned(
                  right: 0,
                  top: 2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF3B30),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: notifications.length,
        itemBuilder: (context, i) {
          final notif = notifications[i];
          return Container(
            margin: EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: notif.iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(notif.icon, color: notif.iconColor, size: 28),
              ),
              title: Text(
                notif.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF181F2B),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  notif.desc,
                  style: TextStyle(fontSize: 15, color: Color(0xFF8A94A6)),
                ),
              ),
              trailing: Icon(Icons.more_horiz, color: Color(0xFF8A94A6)),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NotificationItem {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String desc;
  _NotificationItem({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.desc,
  });
}
