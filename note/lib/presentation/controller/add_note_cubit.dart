import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/usecase/add_note_usecase.dart';
import 'package:note/presentation/controller/note_state.dart';

class AddNoteCubit extends Cubit<NoteState> {
  AddNoteCubit(this.addNoteUseCase) : super(NoteInitial());

  final AddNoteUseCase addNoteUseCase;

  void addNote({
    required String title,
    required String description,
  }) async {
    emit(NoteLoadingState());
    try {
      await addNoteUseCase.execute(
        title: title,
        description: description,
      );
      emit(NoteAddedState());
    } catch (e) {
      emit(NoteErrorState(e.toString()));
    }
  }
}
