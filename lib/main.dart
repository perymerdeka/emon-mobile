import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/profile/profile_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    return GetMaterialApp(
      title: "Application",
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFF7FAFF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color(0xFF181F2B)),
          titleTextStyle: TextStyle(
            color: Color(0xFF181F2B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF181F2B),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF23272F),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      // themeMode di-wrap dengan Obx agar hanya bagian ini yang listen ke observable
      themeMode: profileController.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: (context, child) {
        return Obx(
          () => MediaQuery(data: MediaQuery.of(context), child: child!),
        );
      },
    );
  }
}
