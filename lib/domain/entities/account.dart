class Account {
  final int id;
  final String referenceNumber;
  final String name;
  final String type;
  final double balance;
  final String status;
  final String? parentReference;
  final List<dynamic>? metadata;
  final List<Account>? children;
  final String? createdAt;
  final String? updatedAt;

  Account({
    required this.id,
    required this.referenceNumber,
    required this.name,
    required this.type,
    required this.balance,
    required this.status,
    this.parentReference,
    this.metadata,
    this.children,
    this.createdAt,
    this.updatedAt,
  });
}
