import 'package:core/core.dart';
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
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

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
              context.showSnackBar('Note added successfully!', true);
            } else if (state is NoteErrorState) {
              context.showSnackBar(state.message, false);
            }
          },
          builder: (context, state) {
            if (state is NoteLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: 'Title'),
                      controller: titleController,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Description'),
                        controller: descriptionController,
                        expands: true,
                        minLines: null,
                        maxLines: null,
                      ),
                    ),
                    SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        if (titleController.text.isEmpty ||
                            descriptionController.text.isEmpty) {
                          context.showSnackBar(
                            'Please fill in both title and description',
                            false,
                          );
                        } else {
                          context.read<AddNoteCubit>().addNote(
                            title: titleController.text,
                            description: descriptionController.text,
                          );
                        }
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
