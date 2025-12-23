import 'package:flutter/material.dart';
import 'package:banking_app/presentation_layar/pages/accounts/accounts_list_page.dart';
import 'package:banking_app/presentation_layar/pages/accounts/create_account_page.dart';
import 'package:banking_app/presentation_layar/pages/accounts/account_details_page.dart';
import 'package:banking_app/presentation_layar/pages/accounts/edit_account_page.dart';
import 'package:banking_app/presentation_layar/pages/notifications/notifications_center_page.dart';
import 'package:banking_app/presentation_layar/pages/splash_page.dart';
import 'package:banking_app/presentation_layar/pages/transactions/transactions_history_page.dart';
import 'package:banking_app/presentation_layar/pages/transactions/transaction_page.dart';
import 'package:banking_app/presentation_layar/pages/transactions/transaction_details_page.dart';
import 'package:banking_app/domain/entities/transaction_type.dart';

import '../../presentation_layar/pages/auth_page/ForgotPasswordPage.dart';
import '../../presentation_layar/pages/auth_page/RegisterPage.dart';
import '../../presentation_layar/pages/auth_page/ResetPasswordPage.dart';
import '../../presentation_layar/pages/auth_page/VerifyRegisterOtpPage.dart';
import '../../presentation_layar/pages/auth_page/VerifyResetOtpPage.dart';
import '../../presentation_layar/pages/auth_page/login_page.dart';
import '../../presentation_layar/pages/scheduled/create_scheduled_page.dart';
import '../../presentation_layar/pages/scheduled/scheduled_details_page.dart';
import '../../presentation_layar/pages/scheduled/scheduled_list_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  // Auth routes
  static const String register = '/register';
  static const String verifyRegisterOtp = '/verify-register-otp';
  static const String forgotPassword = '/forgot-password';
  static const String verifyResetOtp = '/verify-reset-otp';
  static const String resetPassword = '/reset-password';

  // Accounts routes
  static const String accounts = '/accounts';
  static const String createAccount = '/accounts/create';

  static const String accountDetails = '/accounts/details';
  static const String editAccount = '/accounts/edit';

  // Transactions routes
  static const String transactions = '/transactions';
  static const String transactionCreate = '/transactions/create';
  static const String deposit = '/transactions/deposit';
  static const String withdraw = '/transactions/withdraw';
  static const String transfer = '/transactions/transfer';
  static const String logs = '/transactions/logs';
  static const String transactionDetails = '/transactions/details';


  static const String notifications = '/notifications';

  // Scheduled
  static const String scheduled = '/scheduled';
  static const String createScheduled = '/scheduled/create';
  static const String scheduledDetails = '/scheduled/details';

  static Map<String, Widget Function(BuildContext)> getAll() {
    return {
      splash: (_) => const SplashPage(),
      login: (_) => const LoginPage(),
      register: (_) => const RegisterPage(),

      verifyRegisterOtp: (context) {
        final email = ModalRoute.of(context)!.settings.arguments as String;
        return VerifyRegisterOtpPage(email: email);
      },

      forgotPassword: (_) => const ForgotPasswordPage(),

      verifyResetOtp: (context) {
        final email = ModalRoute.of(context)!.settings.arguments as String;
        return VerifyResetOtpPage(email: email);
      },

      resetPassword: (context) {
        final args = ModalRoute.of(context)!.settings.arguments as Map;
        return ResetPasswordPage(
          email: args['email'],
          resetToken: args['resetToken'],
        );
      },

      // Accounts
      accounts: (_) => const AccountsListPage(),
      createAccount: (_) => const CreateAccountPage(),

      accountDetails: (_) => const AccountDetailsPage(),
      editAccount: (_) => const EditAccountPage(),

      // Transactions
      transactions: (_) => const TransactionsHistoryPage(),
      transactionCreate: (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        if (args is TransactionType) {
          return TransactionPage(transactionType: args);
        }
        return TransactionPage(transactionType: TransactionType.deposit);
      },
      deposit: (_) => TransactionPage(transactionType: TransactionType.deposit),
      withdraw: (_) => TransactionPage(transactionType: TransactionType.withdraw),
      transfer: (_) => TransactionPage(transactionType: TransactionType.transfer),
      transactionDetails: (_) => const TransactionDetailsPage(),





      // notifications
      notifications: (_) => const NotificationsCenterPage(),
       //scheduled
      scheduled: (_) => const ScheduledListPage(),
      createScheduled: (_) => const CreateScheduledPage(),
      scheduledDetails: (_) => const ScheduledDetailsPage(),

    };
  }
}
