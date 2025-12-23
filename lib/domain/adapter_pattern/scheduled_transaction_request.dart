class ScheduledTransactionRequest {
  final String accountReference;
  final String? relatedAccountReference;
  final String type;
  final double amount;
  final String currency;
  final String frequency;
  final int? dayOfWeek;
  final int? dayOfMonth;
  final String timeOfDay;
  final String timezone;

  const ScheduledTransactionRequest({
    required this.accountReference,
    this.relatedAccountReference,
    required this.type,
    required this.amount,
    required this.currency,
    required this.frequency,
    this.dayOfWeek,
    this.dayOfMonth,
    required this.timeOfDay,
    required this.timezone,
  });
}

