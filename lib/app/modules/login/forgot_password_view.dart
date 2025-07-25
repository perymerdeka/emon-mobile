import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.08),
                Text(
                  'Forgot Your Password?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF181F2B),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  "No worries! Enter your email below and we'll send you a link to reset it.",
                  style: TextStyle(fontSize: 16, color: Color(0xFF8A94A6)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 36),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Address',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF181F2B),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'you@example.com',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFFDEE3EB)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFFDEE3EB)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF3498F3)),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implementasi kirim reset link
                            Get.snackbar(
                              'Reset Link Sent',
                              'Please check your email for the reset link.',
                              backgroundColor: Colors.white,
                              colorText: Color(0xFF181F2B),
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2563EB),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Send Reset Link',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                GestureDetector(
                  onTap: () => Get.offAllNamed(Routes.LOGIN),
                  child: Text(
                    '\u2190 Back to Login',
                    style: TextStyle(
                      color: Color(0xFF2563EB),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
