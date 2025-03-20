import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/presentation/controller/delete_note_cubit.dart';
import 'package:note/presentation/controller/note_state.dart';

class AlertRemoveNoteDialogWidget extends StatefulWidget {
  const AlertRemoveNoteDialogWidget({super.key, required this.docId});

  final String docId;

  @override
  State<AlertRemoveNoteDialogWidget> createState() =>
      _AlertRemoveNoteDialogWidgetState();
}

class _AlertRemoveNoteDialogWidgetState
    extends State<AlertRemoveNoteDialogWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String docId = widget.docId;
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
            if (state is NoteLoadingState)
              CircularProgressIndicator()
            else
              FilledButton(
                onPressed: () {
                  context.read<DeleteNoteCubit>().deleteNote(docId: docId);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                ),
                child: Text('Delete'),
              ),
          ],
        );
      },
      listener: (context, state) {
        if (state is NoteDeletedState) {
          Navigator.of(context).pop();
          context.showSnackBar('Note deleted successfully!', true);
        } else if (state is NoteErrorState) {
          context.showSnackBar('Error: ${state.message}', false);
        }
      },
    );
  }
}
