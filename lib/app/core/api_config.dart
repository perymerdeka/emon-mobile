class ApiConfig {
  // Base URL untuk backend API
  // Gunakan IP address komputer development untuk Android
  // static const String baseUrl = 'http://10.0.2.2:8000'; // Android Emulator
  // static const String baseUrl = 'http://192.168.100.119:8000'; // Real Device (IP komputer development)
  // static const String baseUrl = 'http://localhost:8000'; // iOS Simulator

  // Temporary: Use mock API for testing until backend is fixed
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com'; // Mock API for testing

  // API Endpoints
  static const String authRegister = '/auth/register';
  static const String authLogin = '/auth/token';
  static const String authRefresh = '/auth/refresh';
  static const String authProfile = '/auth/users/me';
  static const String authChangePassword = '/auth/users/me/password';

  // Categories
  static const String categories = '/categories';

  // Transactions
  static const String transactions = '/transactions';

  // Budgets
  static const String budgets = '/budgets';

  // Reports
  static const String reports = '/reports';
  static const String reportsMonthly = '/reports/monthly';
  static const String reportsYearly = '/reports/yearly';
  static const String reportsCustom = '/reports/custom';

  // Recurring Transactions
  static const String recurringTransactions = '/recurring-transactions';
  static const String generateDueTransactions =
      '/recurring-transactions/generate-due';

  // AI Consultation
  static const String aiConsultation = '/ai-consultation';

  // Notifications
  static const String notifications = '/notifications';

  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Timeout settings
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Retry settings
  static const int maxRetries = 3;
  static const int retryDelay = 1000; // 1 second
}
