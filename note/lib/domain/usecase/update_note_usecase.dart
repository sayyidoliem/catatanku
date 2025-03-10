import 'package:note/domain/repositories/note_repositories.dart';

class UpdateNoteUseCase {
  final NoteRepositories repository;

  UpdateNoteUseCase(this.repository);

  Future<void> execute({
    required String title,
    required String description,
    required String docId,
  }) async {
    return repository.updateNote(title, description, docId);
  }
}
