import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note/presentation/widget/list_note_widget.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catatanku'),
        actions: [
          IconButton(
            onPressed: () {
              context.go(PROFILE_PAGE_ROUTE);
            },
            icon: Icon(Icons.person_rounded),
          ),
        ],
      ),
      body: ListNoteWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(ADD_NOTE_PAGE_ROUTE);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// import 'note_cubit.dart'; // Import the NoteCubit

// class NotesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => NoteCubit(
//         addNoteUseCase: AddNoteUseCase(NoteRepositoriesImpl()),
//         updateNoteUseCase: UpdateNoteUseCase(NoteRepositoriesImpl()),
//         deleteNoteUseCase: DeleteNoteUseCase(NoteRepositoriesImpl()),
//         fetchNotesUseCase: GetNotesUseCase(NoteRepositoriesImpl()),
//       )..fetchNotes('userUid'),
//       child: Scaffold(
//         appBar: AppBar(title: Text("Notes")),
//         body: BlocBuilder<NoteCubit, NoteState>(
//           builder: (context, state) {
//             if (state is NoteLoadingState) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is NoteLoadedState) {
//               return ListView.builder(
//                 itemCount: state.notes.length,
//                 itemBuilder: (context, index) {
//                   final note = state.notes[index];
//                   return ListTile(
//                     title: Text(note['title']),
//                     subtitle: Text(note['description']),
//                     trailing: IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () {
//                         context.read<NoteCubit>().deleteNote(
//                               docId: note['id'],
//                               userUid: 'userUid',
//                             );
//                       },
//                     ),
//                   );
//                 },
//               );
//             } else if (state is NoteErrorState) {
//               return Center(child: Text(state.message));
//             } else {
//               return Center(child: Text('No notes available'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
