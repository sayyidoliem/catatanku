import 'package:core/core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmailVerificationScreen(
      actions: [
        EmailVerifiedAction(() {
          context.go(PROFILE_PAGE_ROUTE);
        }),

        AuthCancelledAction((context) {
          FirebaseUIAuth.signOut(context: context);
          context.go(SIGN_IN_PAGE_ROUTE);
        }),
      ],
      // headerBuilder: headerIcon(Icons.verified),
      // sideBuilder: sideIcon(Icons.verified),
      // actionCodeSettings: actionCodeSettings,
    );
  }
}
