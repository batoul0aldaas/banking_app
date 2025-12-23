import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccountLoadRequested extends AccountEvent {}

class AccountDetailsRequested extends AccountEvent {
  final String referenceNumber;
  AccountDetailsRequested({required this.referenceNumber});

  @override
  List<Object?> get props => [referenceNumber];
}

class AccountCreateRequested extends AccountEvent {
  final String name;
  final String type;
  final String? parentReference;

  AccountCreateRequested({
    required this.name,
    required this.type,
    this.parentReference,
  });

  @override
  List<Object?> get props => [name, type, parentReference];
}

class AccountUpdateRequested extends AccountEvent {
  final String referenceNumber;
  final String? name;
  final String? type;
  final String? parentReference;
  final String? status;

  AccountUpdateRequested({
    required this.referenceNumber,
    this.name,
    this.type,
    this.parentReference,
    this.status,
  });

  @override
  List<Object?> get props => [referenceNumber, name, type, parentReference, status];
}

class AccountChangeStateRequested extends AccountEvent {
  final String referenceNumber;
  final String state;

  AccountChangeStateRequested({
    required this.referenceNumber,
    required this.state,
  });

  @override
  List<Object?> get props => [referenceNumber, state];


}

class AccountCalculateInterestRequested extends AccountEvent {
  final String referenceNumber;
  final int days;

  AccountCalculateInterestRequested({
    required this.referenceNumber,
    required this.days,
  });

  @override
  List<Object?> get props => [referenceNumber, days];
}
