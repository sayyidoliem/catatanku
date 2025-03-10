import 'package:auth/auth.dart';
import 'package:catatanku/firebase_options.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note/note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _router = GoRouter(
    initialLocation: '/note',
    routes: <RouteBase>[
      GoRoute(
        name: LOGIN_PAGE_ROUTE,
        path: '/login',
        builder: (context, state) => LoginPage(),
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
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => UpdateNoteCubit(
                    UpdateNoteUseCase(NoteRepositoriesImpl()),
                  ),
              child: EditNotePage(),
            ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}
