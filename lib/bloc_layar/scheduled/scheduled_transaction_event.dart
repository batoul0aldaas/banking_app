import 'package:equatable/equatable.dart';

abstract class ScheduledTransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSchedulesRequested extends ScheduledTransactionEvent {}

class LoadScheduleDetailsRequested extends ScheduledTransactionEvent {
  final String referenceNumber;
  LoadScheduleDetailsRequested(this.referenceNumber);

  @override
  List<Object?> get props => [referenceNumber];
}

class CreateScheduleRequested extends ScheduledTransactionEvent {
  final Map<String, dynamic> payload;
  CreateScheduleRequested(this.payload);

  @override
  List<Object?> get props => [payload];
}

class ToggleScheduleStatusRequested extends ScheduledTransactionEvent {
  final String referenceNumber;
  ToggleScheduleStatusRequested(this.referenceNumber);

  @override
  List<Object?> get props => [referenceNumber];
}
