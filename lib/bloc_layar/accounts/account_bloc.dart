import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Composite Pattern/account_group.dart';
import '../../Composite Pattern/account_leaf.dart';
import '../../data_layar/models/account_interest_model.dart';
import '../../data_layar/models/account_model.dart';
import '../../domain/entities/account.dart';
import 'account_event.dart';
import 'account_state.dart';
import '../../data_layar/repositories/account_repository.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository repository;
  final List<Account> _cachedAccounts = [];

  AccountBloc({required this.repository}) : super(AccountInitial()) {
    on<AccountLoadRequested>(_onLoad);
    on<AccountDetailsRequested>(_onDetails);
    on<AccountCreateRequested>(_onCreate);
    on<AccountUpdateRequested>(_onUpdate);
    on<AccountChangeStateRequested>(_onChangeState);
    on<AccountCalculateInterestRequested>(_onCalculateInterest);

  }


  Future<void> _onLoad(
      AccountLoadRequested event,
      Emitter<AccountState> emit,
      ) async {
    emit(AccountLoading());
    try {
      final res = await repository.getAccounts();
      final list = res['data'] as List;

      final accounts =
      list.map((e) => AccountModel.fromJson(e)).toList();

      _cachedAccounts
        ..clear()
        ..addAll(accounts);
      final Map<String, AccountGroup> groups = {};

      for (final acc in accounts) {
        if (acc.parentReference != null) {
          groups.putIfAbsent(
            acc.parentReference!,
                () => AccountGroup(
              referenceNumber: acc.parentReference!,
              name: 'Group ${acc.parentReference}',
            ),
          );

          groups[acc.parentReference!]!
              .add(AccountLeaf(acc));
        }
      }
      emit(AccountLoadSuccess(List.unmodifiable(_cachedAccounts)));
    } catch (e) {
      emit(AccountFailure(e.toString()));
    }
  }
  Future<void> _onDetails(
      AccountDetailsRequested event,
      Emitter<AccountState> emit,
      ) async {
    emit(AccountLoading());
    try {
      final res =
      await repository.getAccountById(event.referenceNumber);
      final account = AccountModel.fromJson(res['data']);
      emit(AccountDetailsSuccess(account));
    } catch (e) {
      emit(AccountFailure(e.toString()));
    }
  }
  Future<void> _onCreate(
      AccountCreateRequested event,
      Emitter<AccountState> emit,
      ) async {
    emit(AccountLoading());
    try {
      final res = await repository.createAccount(
        name: event.name,
        type: event.type,
        parentReference: event.parentReference,
      );

      final acc = AccountModel.fromJson(res['data']);
      _cachedAccounts.add(acc);

      emit(AccountOperationSuccess(acc));
      emit(AccountLoadSuccess(List.unmodifiable(_cachedAccounts)));
    } catch (e) {
      emit(AccountFailure(e.toString()));
    }
  }
  Future<void> _onUpdate(
      AccountUpdateRequested event,
      Emitter<AccountState> emit,
      ) async {
    emit(AccountLoading());
    try {
      final res = await repository.updateAccount(
        event.referenceNumber,
        name: event.name,
        type: event.type,
        parentReference: event.parentReference,
        status: event.status,
      );

      final updated = AccountModel.fromJson(res['data']);
      final i = _cachedAccounts.indexWhere(
            (a) => a.referenceNumber == event.referenceNumber,
      );

      if (i != -1) _cachedAccounts[i] = updated;

      emit(AccountOperationSuccess(updated));
      emit(AccountLoadSuccess(List.unmodifiable(_cachedAccounts)));
    } catch (e) {
      emit(AccountFailure(e.toString()));
    }
  }
  Future<void> _onChangeState(
      AccountChangeStateRequested event,
      Emitter<AccountState> emit,
      ) async {
    emit(AccountActionLoading());
    try {
      final res = await repository.changeAccountState(
        event.referenceNumber,
        event.state,
      );

      final updated = AccountModel.fromJson(res['data']);
      final i = _cachedAccounts.indexWhere(
            (a) => a.referenceNumber == event.referenceNumber,
      );

      if (i != -1) _cachedAccounts[i] = updated;

      emit(AccountOperationSuccess(updated));
      emit(AccountLoadSuccess(List.unmodifiable(_cachedAccounts)));
    } catch (e) {
      emit(AccountFailure(e.toString()));
    }
  }

  Future<void> _onCalculateInterest(
      AccountCalculateInterestRequested event,
      Emitter<AccountState> emit,
      ) async {
    emit(AccountInterestLoading());
    try {
      final res = await repository.calculateInterest(
        referenceNumber: event.referenceNumber,
        days: event.days,
      );

      final data = res['data'] as Map<String, dynamic>;
      final interest = AccountInterestModel.fromJson(data);

      emit(AccountInterestSuccess(interest));
    } catch (e) {
      emit(AccountInterestFailure(e.toString()));
    }
  }

}
