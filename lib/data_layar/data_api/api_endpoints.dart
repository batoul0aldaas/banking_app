class ApiEndpoints {
  static const String baseUrl =
      "https://5db3000a9a4f.ngrok-free.app/api/v1";

  // ===== Auth =====
  static const String login = "$baseUrl/auth/login";
  static const String register = "$baseUrl/auth/register";
  static const String verifyRegisterOtp = "$baseUrl/auth/verify-register-otp";
  static const String forgotPassword = "$baseUrl/auth/forgot-password";
  static const String verifyResetOtp = "$baseUrl/auth/verify-reset-otp";
  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String refreshOtp = "$baseUrl/auth/refresh-otp";
  static const String logout = "$baseUrl/auth/logout";
  static const String me = "$baseUrl/auth/me";

  // ===== Accounts =====

  static const String addAccount = "$baseUrl/accounts";
  static const String myAccounts = "$baseUrl/accounts/my";
  static const String portfolioBalance = "$baseUrl/accounts/portfolio/balance";

  static String accountDetails(String reference) => "$baseUrl/accounts/$reference";
  static String changeAccountState(String reference) => "$baseUrl/accounts/$reference/state";


  static String calculateInterest(String reference) => "$baseUrl/accounts/$reference/interest";

  // ===== Transactions =====
  static const String transactions = "$baseUrl/transactions";
  static const String createTransaction = "$baseUrl/transactions";

  static String transactionDetails(String reference) =>
      "$baseUrl/transactions/$reference";
  // ===== notifications =====
  static const String notifications = "$baseUrl/notifications";
  static String markAsRead(String reference) =>
      "$baseUrl/notifications/$reference/read";

  // ===== Scheduled Transactions =====
  static const String scheduledTransactions = "$baseUrl/scheduled-transactions";

  static String scheduledTransactionDetails(String reference) =>
      "$baseUrl/scheduled-transactions/$reference";

  static String toggleScheduledTransaction(String reference) =>
      "$baseUrl/scheduled-transactions/$reference/toggle";
}
