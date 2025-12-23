import 'package:flutter/material.dart';

import '../../../data_layar/repositories_impl/auth_repository_impl.dart';
import '../../widgets/primary_button.dart';

class VerifyRegisterOtpPage extends StatefulWidget {
  final String email;
  const VerifyRegisterOtpPage({super.key, required this.email});

  @override
  State<VerifyRegisterOtpPage> createState() => _VerifyRegisterOtpPageState();
}

class _VerifyRegisterOtpPageState extends State<VerifyRegisterOtpPage> {
  final _otp = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              cs.primary.withOpacity(0.85),
              cs.primary.withOpacity(0.65),
              cs.primary.withOpacity(0.4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Icon(Icons.verified_user, size: 80, color: Colors.white),
                    const SizedBox(height: 24),
                    const Text(
                      "Verify OTP",
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Enter the OTP sent to your email",
                      style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _otp,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "OTP Code",
                        prefixIcon: const Icon(Icons.confirmation_number, color: Colors.deepPurple),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Colors.white, width: 1.4),
                        ),
                      ),
                      validator: (v) => v == null || v.isEmpty ? "Required" : null,
                    ),
                    const SizedBox(height: 28),
                    PrimaryButton(
                      label: "Verify OTP",
                      loading: _loading,
                      onPressed: _loading
                          ? null
                          : () async {
                        if (!_formKey.currentState!.validate()) return;
                        setState(() => _loading = true);
                        try {
                          final repo = AuthRepositoryImpl();
                          await repo.verifyRegisterOtp(
                            email: widget.email,
                            otp: _otp.text.trim(),
                          );
                          Navigator.pushReplacementNamed(context, '/accounts');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                        } finally {
                          setState(() => _loading = false);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
