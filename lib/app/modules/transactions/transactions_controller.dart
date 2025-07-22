import 'package:get/get.dart';

class TransactionsController extends GetxController {
  final transactions = [
    {
      'amount': 2500.0,
      'title': 'Freelance Income',
      'subtitle': '',
      'date': 'Today',
      'type': 'income',
    },
    {
      'amount': -150.0,
      'title': 'Office Supplies',
      'subtitle': '',
      'date': 'Yesterday',
      'type': 'expense',
    },
    {
      'amount': 1800.0,
      'title': 'Client Payment',
      'subtitle': '',
      'date': '2 days ago',
      'type': 'income',
    },
    {
      'amount': -20.0,
      'title': 'Software Subscription',
      'subtitle': '',
      'date': '3 days ago',
      'type': 'expense',
    },
    {
      'amount': -300.0,
      'title': 'Travel Expenses',
      'subtitle': '',
      'date': '4 days ago',
      'type': 'expense',
    },
  ].obs;
}
