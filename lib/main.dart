import 'package:auth/auth.dart';
import 'package:catatanku/firebase_options.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note/note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    PhoneAuthProvider(),
    // emailLinkProviderConfig,
    // GoogleProvider(clientId: GOOGLE_CLIENT_ID),
    // AppleProvider(),
    // FacebookProvider(clientId: FACEBOOK_CLIENT_ID),
    // TwitterProvider(
    //   apiKey: TWITTER_API_KEY,
    //   apiSecretKey: TWITTER_API_SECRET_KEY,
    //   redirectUri: TWITTER_REDIRECT_URI,
    // ),
  ]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  GetNoteCubit(GetNotesUseCase(NoteRepositoriesImpl())),
        ),
        BlocProvider(
          create:
              (context) =>
                  DeleteNoteCubit(DeleteNoteUseCase(NoteRepositoriesImpl())),
        ),
        BlocProvider(
          create:
              (context) =>
                  AddNoteCubit(AddNoteUseCase(NoteRepositoriesImpl())),
        ),
        BlocProvider(
          create:
              (context) =>
                  UpdateNoteCubit(UpdateNoteUseCase(NoteRepositoriesImpl())),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _router = GoRouter(
    initialLocation: SIGN_IN_PAGE_ROUTE,
    routes: <RouteBase>[
      GoRoute(
        path: SIGN_IN_PAGE_ROUTE,
        builder: (context, state) => SignInPage(),
      ),
      GoRoute(
        path: FORGOT_PASSWORD_PAGE_ROUTE,
        builder: (context, state) {
          final arguments = state.extra as Map<String, dynamic>;
          final email = arguments['title'];
          return ForgotPasswordPage(email: email ?? '');
        },
      ),
      GoRoute(
        path: VERIFY_EMAIL_PAGE_ROUTE,
        builder: (context, state) => EmailVerificationPage(),
      ),
      GoRoute(
        path: PROFILE_PAGE_ROUTE,
        builder: (context, state) => ProfilePage(),
      ),
      GoRoute(
        name: NOTE_PAGE_ROUTE,
        path: '/note',
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create:
                    (context) =>
                        GetNoteCubit(GetNotesUseCase(NoteRepositoriesImpl())),
              ),
              BlocProvider(
                create:
                    (context) => DeleteNoteCubit(
                      DeleteNoteUseCase(NoteRepositoriesImpl()),
                    ),
              ),
            ],
            child: NotePage(),
          );
        },
      ),
      GoRoute(
        name: ADD_NOTE_PAGE_ROUTE,
        path: '/add-note',
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) =>
                      AddNoteCubit(AddNoteUseCase(NoteRepositoriesImpl())),
              child: AddNotePage(),
            ),
      ),
      GoRoute(
        name: EDIT_NOTE_PAGE_ROUTE,
        path: '/edit-note',
        builder: (context, state) {
          final arguments = state.extra as Map<String, dynamic>;
          final title = arguments['title'];
          final description = arguments['description'];
          final docID = arguments['docID'];
          return BlocProvider(
            create:
                (context) =>
                    UpdateNoteCubit(UpdateNoteUseCase(NoteRepositoriesImpl())),
            child: EditNotePage(
              docID: docID,
              title: title,
              description: description,
            ),
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}
