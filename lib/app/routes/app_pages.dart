import 'package:get/get.dart';

import 'package:emon_mobile/app/modules/login/login_binding.dart';
import 'package:emon_mobile/app/modules/login/login_view.dart';
import 'package:emon_mobile/app/modules/register/register_binding.dart';
import 'package:emon_mobile/app/modules/register/register_view.dart';
import 'package:emon_mobile/app/modules/transactions/transactions_binding.dart';
import 'package:emon_mobile/app/modules/transactions/transactions_view.dart';
import 'package:emon_mobile/app/modules/transactions/add_transaction_view.dart';
import 'package:emon_mobile/app/modules/category/category_binding.dart';
import 'package:emon_mobile/app/modules/category/category_view.dart';
import 'package:emon_mobile/app/modules/reports/reports_binding.dart';
import 'package:emon_mobile/app/modules/reports/reports_view.dart';
import 'package:emon_mobile/app/modules/profile/profile_binding.dart';
import 'package:emon_mobile/app/modules/profile/profile_view.dart';
import 'package:emon_mobile/app/modules/login/forgot_password_view.dart';
import 'package:emon_mobile/app/modules/notifications/notifications_view.dart';
import 'package:emon_mobile/app/modules/all_features/all_features_view.dart';
import 'package:emon_mobile/app/modules/ai_consultation/ai_consultation_view.dart';
import 'package:emon_mobile/app/modules/invoices/invoices_view.dart';
import 'package:emon_mobile/app/modules/bills/bills_view.dart';
import 'package:emon_mobile/app/modules/budgets/budgets_view.dart';
import 'package:emon_mobile/app/modules/savings/savings_view.dart';
import 'package:emon_mobile/app/modules/tax_estimates/tax_estimates_view.dart';
import 'package:emon_mobile/app/modules/accounts/accounts_view.dart';
import 'package:emon_mobile/app/modules/help/help_view.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => TransactionsView(),
      binding: TransactionsBinding(),
    ),
    GetPage(name: _Paths.ADD_TRANSACTION, page: () => AddTransactionView()),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.REPORTS,
      page: () => ReportsView(),
      binding: ReportsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(name: _Paths.FORGOT_PASSWORD, page: () => ForgotPasswordView()),
    GetPage(name: _Paths.NOTIFICATIONS, page: () => NotificationsView()),
    GetPage(name: _Paths.ALL_FEATURES, page: () => AllFeaturesView()),
    GetPage(name: _Paths.AI_CONSULTATION, page: () => AIConsultationView()),
    GetPage(name: _Paths.INVOICES, page: () => InvoicesView()),
    GetPage(name: _Paths.BILLS, page: () => BillsView()),
    GetPage(name: _Paths.BUDGETS, page: () => BudgetsView()),
    GetPage(name: _Paths.SAVINGS, page: () => SavingsView()),
    GetPage(name: _Paths.TAX_ESTIMATES, page: () => TaxEstimatesView()),
    GetPage(name: _Paths.ACCOUNTS, page: () => AccountsView()),
    GetPage(name: _Paths.HELP, page: () => HelpView()),
  ];
}
