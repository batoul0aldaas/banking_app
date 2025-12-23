import 'package:equatable/equatable.dart';
import '../../../domain/entities/scheduled_transaction.dart';

abstract class ScheduledTransactionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScheduledInitial extends ScheduledTransactionState {}

class ScheduledLoading extends ScheduledTransactionState {}

class ScheduledListSuccess extends ScheduledTransactionState {
  final List<ScheduledTransactionEntity> schedules;
  ScheduledListSuccess(this.schedules);

  @override
  List<Object?> get props => [schedules];
}

class ScheduledDetailsSuccess extends ScheduledTransactionState {
  final ScheduledTransactionEntity schedule;
  ScheduledDetailsSuccess(this.schedule);

  @override
  List<Object?> get props => [schedule];
}

class ScheduledOperationSuccess extends ScheduledTransactionState {}

class ScheduledFailure extends ScheduledTransactionState {
  final String error;
  ScheduledFailure(this.error);

  @override
  List<Object?> get props => [error];
}
