abstract class AccountComponent {
  String get referenceNumber;
  String get name;

  void add(AccountComponent component) {
    throw UnsupportedError('Cannot add to leaf');
  }

  void remove(AccountComponent component) {
    throw UnsupportedError('Cannot remove from leaf');
  }

  List<AccountComponent> get children => [];
}
