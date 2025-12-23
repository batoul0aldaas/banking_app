import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data_layar/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onLogin(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await authRepository.login(
        email: event.email,
        password: event.password,
      );

      print("LOGIN SUCCESS:");
      print("User: ${user.name}");
      print("Email: ${user.email}");
      print("Role: ${user.role}");

      emit(AuthAuthenticated());
    } catch (e) {
      print("LOGIN FAILED:");
      print("Error: $e");

      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogout(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }
}
