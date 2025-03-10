import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note/domain/repositories/note_repositories.dart';

class GetNotesUseCase {
  final NoteRepositories repository;

  GetNotesUseCase(this.repository);

  Stream<QuerySnapshot> execute(String userUid) {
    return repository.getNotes(userUid);
  }
}