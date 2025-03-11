import 'package:core/common/name_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note/note.dart';
import 'package:note/presentation/controller/note_state.dart';

class EditNotePage extends StatefulWidget {
  final String? docID;
  final String? title;
  final String? description;

  const EditNotePage({
    super.key,
    required this.docID,
    required this.title,
    required this.description,
  });

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late String docID;
  late String title;
  late String description;
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    docID = widget.docID!;
    title = widget.title!;
    description = widget.description!;
    titleController = TextEditingController(text: title);
    descriptionController = TextEditingController(text: description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              UpdateNoteCubit(UpdateNoteUseCase(NoteRepositoriesImpl())),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Note"),
          leading: IconButton(
            onPressed: () => context.go(NOTE_PAGE_ROUTE),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: BlocConsumer<UpdateNoteCubit, NoteState>(
          listener: (context, state) {
            if (state is NoteUpdatedState) {
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
            } else {
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
                        // Update the note with the current values
                        context.read<UpdateNoteCubit>().updateNote(
                          title: titleController.text,
                          description: descriptionController.text,
                          docId: docID,
                        );
                      },
                      child: Text('Update Note'), // Corrected button text
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
