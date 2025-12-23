import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc_layar/accounts/account_bloc.dart';
import '../../../bloc_layar/accounts/account_event.dart';
import '../../../bloc_layar/accounts/account_state.dart';
import '../../../domain/entities/account.dart';
import '../../../domain/entities/account_update_request.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/primary_button.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final _name = TextEditingController();
  final _type = TextEditingController();
  final _parentRef = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final account = ModalRoute.of(context)!.settings.arguments as Account;
      _name.text = account.name;
      _type.text = account.type;
      _parentRef.text = account.parentReference ?? "";
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _type.dispose();
    _parentRef.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final account = ModalRoute.of(context)!.settings.arguments as Account;
    final cs = Theme.of(context).colorScheme;

    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountOperationSuccess) {
          Navigator.pop(context);
        } else if (state is AccountFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.error}")),
          );
        }
      },
      child: AppScaffold(
        title: "Edit Account",
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 10,
                shadowColor: cs.primary.withOpacity(0.28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _name,
                          decoration: const InputDecoration(labelText: "Account Name"),
                          validator: (v) => v == null || v.trim().isEmpty ? "Required" : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _type,
                          decoration: const InputDecoration(labelText: "Account Type"),
                          validator: (v) => v == null || v.trim().isEmpty ? "Required" : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _parentRef,
                          decoration: const InputDecoration(labelText: "Parent Reference (optional)"),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            label: "Save Changes",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final request = AccountUpdateRequestBuilder(
                                  referenceNumber: account.referenceNumber,
                                )
                                    .withName(_name.text)
                                    .withType(_type.text)
                                    .withParentReference(_parentRef.text)
                                    .build();
                                context.read<AccountBloc>().add(
                                  AccountUpdateRequested(
                                    referenceNumber: request.referenceNumber,
                                    name: request.name,
                                    type: request.type,
                                    parentReference: request.parentReference,
                                    status: request.status,
                                  ),
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
