import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ReportsController extends GetxController {
  final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
  final incomeData = [3000.0, 4500.0, 3800.0, 5000.0, 4200.0, 3900.0];
  final expenseData = [1800.0, 2500.0, 2100.0, 3200.0, 2900.0, 2300.0];

  final breakdown = [
    {'label': 'Freelance', 'value': 1200.0, 'color': Color(0xFF6366F1)},
    {'label': 'Consulting', 'value': 900.0, 'color': Color(0xFFF59E42)},
    {'label': 'Investments', 'value': 1100.0, 'color': Color(0xFF10B981)},
    {'label': 'Other', 'value': 600.0, 'color': Color(0xFFD1D5DB)},
  ];
}
