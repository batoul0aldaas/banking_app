class AccountInterest {
  final String accountReference;
  final String type;
  final double marketRate;
  final int days;
  final double interest;

  AccountInterest({
    required this.accountReference,
    required this.type,
    required this.marketRate,
    required this.days,
    required this.interest,
  });
}
