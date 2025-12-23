import 'package:banking_app/data_layar/repositories_impl/scheduled_transaction_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_layar/accounts/account_bloc.dart';
import 'bloc_layar/auth/auth_bloc.dart';
import 'bloc_layar/notifications/notifications_bloc.dart';
import 'bloc_layar/scheduled/scheduled_transaction_bloc.dart';
import 'bloc_layar/transactions/transaction_bloc.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

import 'data_layar/data_api/api_service.dart';
import 'data_layar/repositories_impl/account_repository_impl.dart';
import 'data_layar/repositories_impl/auth_repository_impl.dart';
import 'data_layar/repositories_impl/notifications_repository_impl.dart';
import 'data_layar/repositories_impl/transaction_repository_impl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = AuthRepositoryImpl();
    final accountRepo = AccountRepositoryImpl(api: ApiService());
    final transactionRepo = TransactionRepositoryImpl(api:ApiService());
    final notificationsRepo = NotificationRepositoryImpl(api: ApiService());
    final scheduledRepo = ScheduledTransactionRepositoryImpl(api: ApiService());



    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(authRepository: authRepo)),
        BlocProvider(create: (_) => AccountBloc(repository: accountRepo)),
        BlocProvider(create: (_) => TransactionBloc(repository: transactionRepo)),
        BlocProvider(create: (_) => NotificationsBloc(repository: notificationsRepo)),
        BlocProvider(
          create: (_) => ScheduledTransactionBloc(
            repository: scheduledRepo,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Banking App',
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.getAll(),
      ),
    );
  }
}
