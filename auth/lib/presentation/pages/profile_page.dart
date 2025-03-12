import 'package:core/core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          onPressed: () => context.go(NOTE_PAGE_ROUTE),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      actions: [
        SignedOutAction((context) {
          context.go(SIGN_IN_PAGE_ROUTE);
        }),
        // mfaAction,
      ],
      providers: [EmailAuthProvider()],
      showUnlinkConfirmationDialog: true,
      showDeleteConfirmationDialog: true,
      showMFATile: true,
      // actionCodeSettings: actionCodeSettings,
      // showMFATile: kIsWeb ||
      //     platform == TargetPlatform.iOS ||
      //     platform == TargetPlatform.android,
    );
  }
}
