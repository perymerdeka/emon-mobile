import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.04 > 24 ? 24.0 : size.width * 0.04;
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
        title: const Text(
          'Profile',
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
                  children: [
                    SizedBox(height: 16),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 56,
                          backgroundColor: Color(0xFFFFE5E5),
                          backgroundImage: AssetImage(controller.avatar.value),
                        ),
                        Positioned(
                          bottom: 6,
                          right: 6,
                          child: GestureDetector(
                            onTap: () => _showEditAvatarDialog(),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Color(0xFFE3F0FF),
                              child: Icon(
                                Icons.edit,
                                color: Color(0xFF8A94A6),
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Obx(
                      () => Text(
                        controller.name.value,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Color(0xFF181F2B),
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller.email.value,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF8A94A6),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF181F2B),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    _profileCard([
                      _profileTile(
                        Icons.lock_outline,
                        'Password',
                        'Change your password',
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Color(0xFF8A94A6),
                        ),
                      ),
                      Obx(
                        () => _profileTile(
                          Icons.nightlight_round,
                          'Dark Mode',
                          'Enable dark mode',
                          trailing: Switch(
                            value: controller.isDarkMode.value,
                            onChanged: (val) =>
                                controller.isDarkMode.value = val,
                            activeColor: Color(0xFF181F2B),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF181F2B),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    _profileCard([
                      GestureDetector(
                        onTap: () => controller.showNotifDropdown.value =
                            !controller.showNotifDropdown.value,
                        child: _profileTile(
                          Icons.notifications_none,
                          'Notifications',
                          '',
                          trailing: Obx(
                            () => Icon(
                              controller.showNotifDropdown.value
                                  ? Icons.keyboard_arrow_up
                                  : Icons.arrow_forward_ios,
                              size: 18,
                              color: Color(0xFF8A94A6),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => controller.showNotifDropdown.value
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      _notifSwitchTile(
                                        'Transaction Alerts',
                                        'Receive alerts for every transaction',
                                        controller.transactionAlerts,
                                      ),
                                      Divider(
                                        height: 1,
                                        color: Color(0xFFF0F0F0),
                                      ),
                                      _notifSwitchTile(
                                        'Budget Reminders',
                                        'Get reminders when you’re nearing your budget',
                                        controller.budgetReminders,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                      _profileTile(
                        Icons.language,
                        'Language',
                        '',
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Color(0xFF8A94A6),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Color(0xFF181F2B),
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

Widget _profileCard(List<Widget> children) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      children: List.generate(children.length, (i) {
        return Column(
          children: [
            if (i > 0) Divider(height: 1, color: Color(0xFFF0F0F0)),
            children[i],
          ],
        );
      }),
    ),
  );
}

Widget _profileTile(
  IconData icon,
  String title,
  String subtitle, {
  Widget? trailing,
}) {
  return ListTile(
    leading: Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Color(0xFFF7FAFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Color(0xFF8A94A6)),
    ),
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Color(0xFF181F2B),
      ),
    ),
    subtitle: subtitle.isNotEmpty
        ? Text(
            subtitle,
            style: TextStyle(fontSize: 14, color: Color(0xFF8A94A6)),
          )
        : null,
    trailing: trailing,
    onTap: () {
      // Handle different profile tile actions
      if (title == 'Password') {
        _showChangePasswordDialog();
      } else if (title == 'Language') {
        _showLanguageDialog();
      }
    },
  );
}

void _showEditAvatarDialog() {
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
            'Change Profile Picture',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF181F2B),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.camera_alt, color: Color(0xFF2563EB)),
            title: Text('Take Photo'),
            onTap: () {
              Get.back();
              Get.snackbar(
                'Info',
                'Camera functionality will be implemented here',
                backgroundColor: Color(0xFF2563EB),
                colorText: Colors.white,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library, color: Color(0xFF2563EB)),
            title: Text('Choose from Gallery'),
            onTap: () {
              Get.back();
              Get.snackbar(
                'Info',
                'Gallery functionality will be implemented here',
                backgroundColor: Color(0xFF2563EB),
                colorText: Colors.white,
              );
            },
          ),
        ],
      ),
    ),
  );
}

void _showChangePasswordDialog() {
  Get.dialog(
    AlertDialog(
      title: Text('Change Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Current Password',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'New Password',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm New Password',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement password change functionality
            Get.back();
            Get.snackbar(
              'Success',
              'Password changed successfully!',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          },
          child: Text('Change'),
        ),
      ],
    ),
  );
}

void _showLanguageDialog() {
  Get.dialog(
    AlertDialog(
      title: Text('Select Language'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('English'),
            trailing: Icon(Icons.check, color: Color(0xFF2563EB)),
            onTap: () {
              Get.back();
              Get.snackbar(
                'Info',
                'Language changed to English',
                backgroundColor: Color(0xFF2563EB),
                colorText: Colors.white,
              );
            },
          ),
          ListTile(
            title: Text('Indonesian'),
            onTap: () {
              Get.back();
              Get.snackbar(
                'Info',
                'Language changed to Indonesian',
                backgroundColor: Color(0xFF2563EB),
                colorText: Colors.white,
              );
            },
          ),
        ],
      ),
    ),
  );
}

Widget _notifSwitchTile(String title, String subtitle, RxBool value) {
  return Obx(
    () => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color(0xFF181F2B),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 14, color: Color(0xFF8A94A6)),
      ),
      trailing: Switch(
        value: value.value,
        onChanged: (val) => value.value = val,
        activeColor: Color(0xFF2563EB),
      ),
    ),
  );
}
