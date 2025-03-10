import 'package:note/domain/repositories/note_repositories.dart';

class DeleteNoteUseCase {
  final NoteRepositories repository;

  DeleteNoteUseCase(this.repository);

  Future<void> execute({required String docId}) async {
    return repository.deleteNote(docId);
  }
}
