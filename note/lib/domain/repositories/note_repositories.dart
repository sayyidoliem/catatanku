import 'package:cloud_firestore/cloud_firestore.dart';

abstract class NoteRepositories {
  Future<void> addNote(String title, String description);

  Future<void> updateNote(String title, String description, String docId);

  Future<void> deleteNote(String docId);

  Stream<QuerySnapshot> getNotes();
}
