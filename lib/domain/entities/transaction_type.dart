enum TransactionType {
  deposit('deposit'),
  withdraw('withdraw'),
  transfer('transfer');

  final String value;

  const TransactionType(this.value);

  static TransactionType fromString(String value) {
    return TransactionType.values.firstWhere(
          (type) => type.value == value,
      orElse: () => throw ArgumentError('Unknown transaction type: $value'),
    );
  }
}