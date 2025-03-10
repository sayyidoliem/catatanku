import 'package:core/common/name_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note/data/repositories/note_repositories_impl.dart';
import 'package:note/domain/usecase/add_note_usecase.dart';
import 'package:note/presentation/controller/add_note_cubit.dart';
import 'package:note/presentation/controller/note_state.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit(AddNoteUseCase(NoteRepositoriesImpl())),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Note"),
          leading: IconButton(
            onPressed: () => context.go(NOTE_PAGE_ROUTE),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: BlocConsumer<AddNoteCubit, NoteState>(
          listener: (context, state) {
            if (state is NoteAddedState) {
              context.go(NOTE_PAGE_ROUTE);
            } else if (state is NoteErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is NoteLoadingState) {
              return Center(child: CircularProgressIndicator());
            } 
            else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: 'Title'),
                      controller: titleController,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: 'Description'),
                      controller: descriptionController,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AddNoteCubit>().addNote(
                          title: titleController.text,
                          description: descriptionController.text,
                        );
                      },
                      child: Text('Add Note'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
