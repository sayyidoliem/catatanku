import 'package:core/common/name_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note/presentation/controller/get_note_cubit.dart';
import 'package:note/presentation/controller/note_state.dart';
import 'package:note/presentation/widget/alert_remove_note_dialog_widget.dart';
import 'package:slideable/slideable.dart';

class ListNoteWidget extends StatefulWidget {
  const ListNoteWidget({super.key});

  @override
  State<ListNoteWidget> createState() => _ListNoteWidgetState();
}

class _ListNoteWidgetState extends State<ListNoteWidget> {
  Future<void> _refreshNotes(BuildContext context) async {
    context.read<GetNoteCubit>().fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    context.read<GetNoteCubit>().fetchNotes();
    return BlocBuilder<GetNoteCubit, NoteState>(
      builder: (context, state) {
        if (state is NoteLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is NoteLoadedState) {
          return RefreshIndicator(
            onRefresh: () => _refreshNotes(context), // Trigger the refresh
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: state.notes.docs.length,
              itemBuilder: (context, index) {
                var noteInfo =
                    state.notes.docs[index].data() as Map<String, dynamic>;
                String docID = state.notes.docs[index].id;
                String title = noteInfo['title'];
                String description = noteInfo['description'];
                return Slideable(
                  items: [
                    ActionItems(
                      icon: const Icon(Icons.delete),
                      onPress: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) =>
                                  AlertRemoveNoteDialogWidget(docId: docID),
                        );
                      },
                      backgroudColor: Colors.transparent,
                    ),
                  ],
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
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
                      onTap:
                          () => context.go(
                            EDIT_NOTE_PAGE_ROUTE,
                            extra: {
                              'title': title,
                              'description': description,
                              'docID': docID,
                            },
                          ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is NoteErrorState) {
          return Center(child: Text(state.message));
        }

        return SizedBox.shrink();
      },
    );
  }
}
