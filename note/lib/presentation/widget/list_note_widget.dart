import 'package:core/common/name_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note/presentation/controller/get_note_cubit.dart';
import 'package:note/presentation/controller/note_state.dart';
import 'package:note/presentation/widget/alert_remove_note_dialog_widget.dart';

class ListNoteWidget extends StatelessWidget {
  const ListNoteWidget({super.key, required this.userUid});

  final String userUid;

  @override
  Widget build(BuildContext context) {
    context.read<GetNoteCubit>().fetchNotes(userUid);

    return BlocBuilder<GetNoteCubit, NoteState>(
      builder: (context, state) {
        if (state is NoteLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is NoteLoadedState) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: state.notes.docs.length,
            itemBuilder: (context, index) {
              var noteInfo =
                  state.notes.docs[index].data() as Map<String, dynamic>;
              String docID = state.notes.docs[index].id;
              String title = noteInfo['title'];
              String description = noteInfo['description'];

              return Ink(
                decoration: BoxDecoration(
                  // color: CustomColors.firebaseGrey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  title: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      // Show the dialog and pass the docID to it
                      showDialog(
                        context: context,
                        builder:
                            (context) =>
                                AlertRemoveNoteDialogWidget(docId: docID),
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                  onTap:
                      () => context.go(
                        EDIT_NOTE_PAGE_ROUTE,
                        extra: {'docID': docID},
                      ),
                ),
              );
            },
          );
        } else if (state is NoteErrorState) {
          return Center(child: Text(state.message));
        }

        return SizedBox.shrink();
      },
    );
  }
}
