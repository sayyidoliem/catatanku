import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/presentation/controller/delete_note_cubit.dart';
import 'package:note/presentation/controller/note_state.dart';

class AlertRemoveNoteDialogWidget extends StatelessWidget {
  final String docId;

  const AlertRemoveNoteDialogWidget({super.key, required this.docId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteNoteCubit, NoteState>(
      builder: (context, state) {
        return AlertDialog(
          icon: Icon(Icons.warning_sharp),
          title: const Text('Remove Note'),
          content: const Text(
            'Are you sure want to delete this note?\nThis action cannot be undone',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Discard'),
            ),
            FilledButton(
              onPressed: () {
                context.read<DeleteNoteCubit>().deleteNote(docId: docId);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
      listener: (context, state) {
        if (state is NoteDeletedState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Note deleted successfully!')),
          );
        } else if (state is NoteErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
        }
      },
    );
  }
}
