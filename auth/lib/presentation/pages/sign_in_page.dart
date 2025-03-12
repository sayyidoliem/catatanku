import 'package:auth/data/repositories/auth_repositories_impl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: [EmailAuthProvider()],
      headerBuilder: (context, constraints, shrinkOffset) {
        return Padding(
          padding: EdgeInsets.all(20),
          // child: Image.network('assets/note.png'),
          child: CachedNetworkImage(
            imageUrl:
                'https://i.pinimg.com/originals/b6/cd/e8/b6cde81d1c489b0e20d85a6e06c5f8f9.png',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      },
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            action == AuthAction.signIn
                ? 'Welcome to Catatanku! Please sign in to continue.'
                : 'Welcome to Catatanku! Please create an account to continue',
          ),
        );
      },
      sideBuilder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              imageUrl:
                  'https://i.pinimg.com/originals/b6/cd/e8/b6cde81d1c489b0e20d85a6e06c5f8f9.png',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        );
      },
      showPasswordVisibilityToggle: true,
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) async {
          await UserStorage.saveUserUID(state.user!.uid);
          await AuthRepositoriesImpl().addUserUID();
        }),
        ForgotPasswordAction((context, email) {
          context.go(FORGOT_PASSWORD_PAGE_ROUTE, extra: {'email': email});
        }),
        AuthStateChangeAction((context, state) {
          final user = switch (state) {
            SignedIn(user: final user) => user,
            CredentialLinked(user: final user) => user,
            UserCreated(credential: final cred) => cred.user,
            _ => null,
          };
          switch (user) {
            case User(emailVerified: true):
              context.go(NOTE_PAGE_ROUTE);
            case User(emailVerified: false, email: final String _):
              context.go(VERIFY_EMAIL_PAGE_ROUTE);
            case User(emailVerified: false, email: null):
          }
        }),
      ],
    );
  }
}
