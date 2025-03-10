import 'package:auth/auth.dart';
import 'package:core/common/name_router.dart';
import 'package:catatanku/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note/data/repositories/note_repositories_impl.dart';
import 'package:note/domain/usecase/get_note_usecase.dart';
import 'package:note/note.dart';
import 'package:note/presentation/controller/get_note_cubit.dart';

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
          return BlocProvider(
            create:
                (context) =>
                    GetNoteCubit(GetNotesUseCase(NoteRepositoriesImpl())),
            child: NotePage(),
          );
        },
      ),
      GoRoute(
        name: ADD_NOTE_PAGE_ROUTE,
        path: '/add-note',
        builder: (context, state) => AddNotePage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}
