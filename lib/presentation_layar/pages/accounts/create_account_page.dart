import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc_layar/accounts/account_bloc.dart';
import '../../../bloc_layar/accounts/account_event.dart';
import '../../../bloc_layar/accounts/account_state.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/primary_button.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _name = TextEditingController();
  final _type = TextEditingController();
  final _parentRef = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _name.dispose();
    _type.dispose();
    _parentRef.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        title: "Create Account",
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
                        Text(
                          "Create New Account",
                          style: TextStyle(
                            color: cs.primary,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _name,
                          decoration: const InputDecoration(
                            labelText: "Account Name",
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (v) => v == null || v.trim().isEmpty ? "Required" : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _type,
                          decoration: const InputDecoration(
                            labelText: "Account Type",
                            prefixIcon: Icon(Icons.category_outlined),
                          ),
                          validator: (v) => v == null || v.trim().isEmpty ? "Required" : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _parentRef,
                          decoration: const InputDecoration(
                            labelText: "Parent Reference (Optional)",
                            prefixIcon: Icon(Icons.account_tree_outlined),
                            hintText: "مثال: ACC-000002",
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            label: "Create",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final parent = _parentRef.text.trim();
                                context.read<AccountBloc>().add(
                                  AccountCreateRequested(
                                    name: _name.text.trim(),
                                    type: _type.text.trim(),
                                    parentReference: parent.isEmpty ? null : parent,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
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
