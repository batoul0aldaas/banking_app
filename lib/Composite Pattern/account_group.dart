import 'account_component.dart';

class AccountGroup extends AccountComponent {
  @override
  final String referenceNumber;

  @override
  final String name;

  final List<AccountComponent> _children = [];

  AccountGroup({
    required this.referenceNumber,
    required this.name,
  });

  @override
  void add(AccountComponent component) {
    _children.add(component);
  }

  @override
  void remove(AccountComponent component) {
    _children.remove(component);
  }

  @override
  List<AccountComponent> get children => List.unmodifiable(_children);
}
