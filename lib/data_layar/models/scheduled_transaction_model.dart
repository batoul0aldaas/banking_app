
class ScheduledTransactionModel {
  final String referenceNumber;
  final String status;
  final String type;
  final double amount;
  final String currency;

  final String? accountReference;
  final String? relatedAccountReference;

  final String frequency;
  final int? dayOfWeek;
  final int? dayOfMonth;
  final String timeOfDay;
  final String timezone;

  final DateTime nextRunAt;
  final DateTime? lastRunAt;
  final int runsCount;
  final String? lastError;

  final DateTime createdAt;
  final DateTime updatedAt;

  const ScheduledTransactionModel({
    required this.referenceNumber,
    required this.status,
    required this.type,
    required this.amount,
    required this.currency,
    required this.accountReference,
    required this.relatedAccountReference,
    required this.frequency,
    required this.dayOfWeek,
    required this.dayOfMonth,
    required this.timeOfDay,
    required this.timezone,
    required this.nextRunAt,
    required this.lastRunAt,
    required this.runsCount,
    required this.lastError,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduledTransactionModel.fromJson(Map<String, dynamic> json) {
    return ScheduledTransactionModel(
      referenceNumber: json['reference_number']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency']?.toString() ?? '',
      accountReference: json['account_reference']?.toString(),
      relatedAccountReference: json['related_account_reference']?.toString(),
      frequency: json['frequency']?.toString() ?? '',
      dayOfWeek: json['day_of_week'] is int
          ? json['day_of_week'] as int
          : int.tryParse(json['day_of_week']?.toString() ?? ''),
      dayOfMonth: json['day_of_month'] is int
          ? json['day_of_month'] as int
          : int.tryParse(json['day_of_month']?.toString() ?? ''),
      timeOfDay: json['time_of_day']?.toString() ?? '',
      timezone: json['timezone']?.toString() ?? '',
      nextRunAt: _safeDate(json['next_run_at']),
      lastRunAt:
          json['last_run_at'] != null ? _safeDate(json['last_run_at']) : null,
      runsCount: json['runs_count'] is int
          ? json['runs_count'] as int
          : int.tryParse(json['runs_count']?.toString() ?? '') ?? 0,
      lastError: json['last_error']?.toString(),
      createdAt: _safeDate(json['created_at']),
      updatedAt: _safeDate(json['updated_at']),
    );
  }

  static DateTime _safeDate(dynamic value) {
    final asString = value?.toString();
    if (asString == null || asString.isEmpty) {
      return DateTime.now();
    }
    return DateTime.parse(asString);
  }

  static List<ScheduledTransactionModel> listFromJson(List list) {
    return list.map((e) => ScheduledTransactionModel.fromJson(e)).toList();
  }

}

