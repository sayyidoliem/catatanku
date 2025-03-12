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