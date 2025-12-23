import 'package:equatable/equatable.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/account_interest.dart';

abstract class AccountState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoadSuccess extends AccountState {
  final List<Account> accounts;
  final double? portfolioBalance;

  AccountLoadSuccess(this.accounts, {this.portfolioBalance});

  @override
  List<Object?> get props => [accounts, portfolioBalance ?? 0];
}

class AccountDetailsSuccess extends AccountState {
  final Account account;
  AccountDetailsSuccess(this.account);

  @override
  List<Object?> get props => [account];
}

class AccountOperationSuccess extends AccountState {
  final Account account;
  AccountOperationSuccess(this.account);

  @override
  List<Object?> get props => [account];
}

class AccountFailure extends AccountState {
  final String error;
  AccountFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class AccountActionLoading extends AccountState {}

class AccountInterestLoading extends AccountState {}

class AccountInterestSuccess extends AccountState {
  final AccountInterest interest;

  AccountInterestSuccess(this.interest);

  @override
  List<Object?> get props => [interest];
}

class AccountInterestFailure extends AccountState {
  final String error;

  AccountInterestFailure(this.error);

  @override
  List<Object?> get props => [error];
}
