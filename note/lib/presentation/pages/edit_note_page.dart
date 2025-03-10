import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/data/repositories/note_repositories_impl.dart';
import 'package:note/domain/usecase/update_note_usecase.dart';
import 'package:note/presentation/controller/note_state.dart';
import 'package:note/presentation/controller/update_note_cubit.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              UpdateNoteCubit(UpdateNoteUseCase(NoteRepositoriesImpl()))..updateNoteUseCase,
      child: Scaffold(
        appBar: AppBar(title: Text('Edit your note')),
        body: BlocBuilder<UpdateNoteCubit, NoteState>(builder: (context, state) {
          if (state is NoteLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NoteDeletedState) {
            return Center(child: Text('Note updated successfully'));
          } else if (state is NoteErrorState) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No notes available'));
          }
        }),
      ),
    );
  }
}
