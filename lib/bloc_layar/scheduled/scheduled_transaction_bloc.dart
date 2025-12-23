import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data_layar/repositories/scheduled_transaction_repository.dart';
import 'scheduled_transaction_event.dart';
import 'scheduled_transaction_state.dart';

class ScheduledTransactionBloc
    extends Bloc<ScheduledTransactionEvent, ScheduledTransactionState> {
  final ScheduledTransactionRepository repository;

  ScheduledTransactionBloc({required this.repository})
      : super(ScheduledInitial()) {
    on<LoadSchedulesRequested>(_onLoadAll);
    on<LoadScheduleDetailsRequested>(_onLoadDetails);
    on<CreateScheduleRequested>(_onCreate);
    on<ToggleScheduleStatusRequested>(_onToggle);
  }

  Future<void> _onLoadAll(
      LoadSchedulesRequested event, Emitter emit) async {
    emit(ScheduledLoading());
    try {
      final data = await repository.getSchedules();
      emit(ScheduledListSuccess(data));
    } catch (e) {
      emit(ScheduledFailure(e.toString()));
    }
  }

  Future<void> _onLoadDetails(
      LoadScheduleDetailsRequested event, Emitter emit) async {
    emit(ScheduledLoading());
    try {
      final data =
      await repository.getScheduleDetails(event.referenceNumber);
      emit(ScheduledDetailsSuccess(data));
    } catch (e) {
      emit(ScheduledFailure(e.toString()));
    }
  }

  Future<void> _onCreate(
      CreateScheduleRequested event, Emitter emit) async {
    emit(ScheduledLoading());
    try {
      await repository.createSchedule(
        accountReference: event.payload['account_reference'],
        relatedAccountReference: event.payload['related_account_reference'],
        type: event.payload['type'],
        amount: event.payload['amount'],
        currency: event.payload['currency'],
        frequency: event.payload['frequency'],
        dayOfWeek: event.payload['day_of_week'],
        dayOfMonth: event.payload['day_of_month'],
        timeOfDay: event.payload['time_of_day'],
        timezone: event.payload['timezone'],
      );

      emit(ScheduledOperationSuccess());

      final data = await repository.getSchedules();
      emit(ScheduledListSuccess(data));
    } catch (e) {
      emit(ScheduledFailure(e.toString()));
    }
  }


  Future<void> _onToggle(
      ToggleScheduleStatusRequested event, Emitter emit) async {
    emit(ScheduledLoading());
    try {
      final updated =
      await repository.toggleScheduleStatus(event.referenceNumber);
      emit(ScheduledDetailsSuccess(updated));
    } catch (e) {
      emit(ScheduledFailure(e.toString()));
    }
  }

}
