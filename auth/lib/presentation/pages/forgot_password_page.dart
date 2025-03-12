import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordScreen(
      email: email,
      headerMaxExtent: 200,
      // headerBuilder: headerIcon(Icons.lock),
      // sideBuilder: sideIcon(Icons.lock),
    );
  }
}