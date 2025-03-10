import 'package:note/domain/repositories/note_repositories.dart';

class AddNoteUseCase {
  final NoteRepositories repository;

  AddNoteUseCase(this.repository);

  Future<void> execute({
    required String title,
    required String description,
  }) async {
    return repository.addNote(
       title,
       description,
    );
  }
}
