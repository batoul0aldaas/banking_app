import '../../domain/entities/account.dart';
import 'account_component.dart';

class AccountLeaf extends AccountComponent {
  final Account account;

  AccountLeaf(this.account);

  @override
  String get referenceNumber => account.referenceNumber;

  @override
  String get name => account.name;
}
