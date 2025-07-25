import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Import RegisterView
import 'login_controller.dart';
import 'package:emon_mobile/app/routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    RxString emailError = ''.obs;
    RxString passwordError = ''.obs;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/emon.png',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(
                'Freelance Finance',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            final emailRegex = RegExp(
                              r'^[^@\s]+@[^@\s]+\.[^@\s]+ *',
                            );
                            if (!emailRegex.hasMatch(value)) {
                              return 'Format email tidak valid';
                            }
                            return null;
                          },
                        ),
                        Obx(
                          () => emailError.value.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      emailError.value,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            if (value.length < 6) {
                              return 'Password minimal 6 karakter';
                            }
                            return null;
                          },
                        ),
                        Obx(
                          () => passwordError.value.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      passwordError.value,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue[600],
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              emailError.value = '';
                              passwordError.value = '';
                              if (formKey.currentState!.validate()) {
                                controller.login(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[600],
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.REGISTER),
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
