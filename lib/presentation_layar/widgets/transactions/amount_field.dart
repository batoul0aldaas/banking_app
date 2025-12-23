import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const AmountField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(labelText: 'Amount'),
      validator: validator ??
          ((v) => v == null || v.isEmpty ? 'Required' : null),
    );
  }
}



