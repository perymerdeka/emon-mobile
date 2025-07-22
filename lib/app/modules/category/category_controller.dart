import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CategoryController extends GetxController {
  final incomeCategories = [
    {
      'icon': Icons.attach_money,
      'color': Color(0xFFDDEBFF),
      'iconColor': Color(0xFF3498F3),
      'title': 'Salary',
      'desc': 'Monthly Income',
    },
    {
      'icon': Icons.work_outline,
      'color': Color(0xFFDFFFEA),
      'iconColor': Color(0xFF27AE60),
      'title': 'Freelance',
      'desc': 'Project-based',
    },
    {
      'icon': Icons.show_chart,
      'color': Color(0xFFF3E8FF),
      'iconColor': Color(0xFF9B59B6),
      'title': 'Investments',
      'desc': 'Dividends, Interest',
    },
  ].obs;

  final expenseCategories = [
    {
      'icon': Icons.home_outlined,
      'color': Color(0xFFFFE5E5),
      'iconColor': Color(0xFFE74C3C),
      'title': 'Rent',
      'desc': 'Housing',
    },
    {
      'icon': Icons.lightbulb_outline,
      'color': Color(0xFFFFF9E5),
      'iconColor': Color(0xFFF1C40F),
      'title': 'Utilities',
      'desc': 'Electricity, Water, Internet',
    },
    {
      'icon': Icons.local_pizza_outlined,
      'color': Color(0xFFFFF3E5),
      'iconColor': Color(0xFFF39C12),
      'title': 'Food',
      'desc': 'Groceries, Dining out',
    },
  ].obs;
}
