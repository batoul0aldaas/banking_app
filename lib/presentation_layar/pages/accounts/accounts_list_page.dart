import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc_layar/accounts/account_bloc.dart';
import '../../../bloc_layar/accounts/account_event.dart';
import '../../../bloc_layar/accounts/account_state.dart';
import '../../../core/routes/app_routes.dart';
import '../../../domain/entities/account.dart';
import '../../../domain/entities/account_create_request.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/card_account.dart';
import '../../widgets/loading_indicator.dart';

class AccountsListPage extends StatefulWidget {
  const AccountsListPage({super.key});

  @override
  State<AccountsListPage> createState() => _AccountsListPageState();
}

class _AccountsListPageState extends State<AccountsListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountBloc>().add(AccountLoadRequested());
    });
  }

  Future<void> _showAddChildAccountDialog(String parentRef) async {
    final nameController = TextEditingController();
    final typeController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Child Account"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Account Name"),
                validator: (v) => v == null || v.trim().isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(labelText: "Account Type"),
                validator: (v) => v == null || v.trim().isEmpty ? "Required" : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final builder = AccountCreateRequestBuilder()
                    .withName(nameController.text)
                    .withType(typeController.text)
                    .withParentReference(parentRef);

                final request = builder.build();
                context.read<AccountBloc>().add(AccountCreateRequested(
                  name: request.name,
                  type: request.type,
                  parentReference: request.parentReference,
                ));
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountTile(Account account, List<Account> allAccounts) {

    final subAccounts = allAccounts.where((a) => a.parentReference == account.referenceNumber).toList();

    return ExpansionTile(
      title: AccountCard(
        account: account,
        onTap: () async {
          final refreshed = await Navigator.pushNamed(
            context,
            AppRoutes.accountDetails,
            arguments: account.referenceNumber,
          );

          if (refreshed == true) {
            context.read<AccountBloc>().add(AccountLoadRequested());
          }
        },

      ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Row(
          children: [
            const Spacer(),
            TextButton.icon(
              onPressed: () => _showAddChildAccountDialog(account.referenceNumber),
              icon: const Icon(Icons.add_circle_outline, size: 20),
              label: const Text("Add Sub Account"),
            ),
          ],
        ),
        ...subAccounts.map((sub) => Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: AccountCard(
            account: sub,
            onTap: () async {
              final refreshed = await Navigator.pushNamed(
                context,
                AppRoutes.accountDetails,
                arguments: account.referenceNumber,
              );

              if (refreshed == true) {
                context.read<AccountBloc>().add(AccountLoadRequested());
              }
            },

          ),
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Accounts",
      showFab: true,
      fab: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.createAccount),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) return const LoadingIndicator();

          if (state is AccountLoadSuccess) {
            if (state.accounts.isEmpty) return const Center(child: Text("No accounts available"));

            final mainAccounts = state.accounts.where((a) => a.parentReference == null).toList();

            return ListView.builder(
              itemCount: mainAccounts.length,
              itemBuilder: (context, i) {
                final account = mainAccounts[i];
                return _buildAccountTile(account, state.accounts);
              },
            );
          }

          if (state is AccountFailure) {
            return Center(child: Text("Error: ${state.error}"));
          }

          return const Center(child: Text("No data"));
        },
      ),
    );
  }
}
