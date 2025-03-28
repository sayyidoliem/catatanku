import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/usecase/update_note_usecase.dart';
import 'package:note/presentation/controller/note_state.dart';

class UpdateNoteCubit extends Cubit<NoteState> {
  UpdateNoteCubit(this.updateNoteUseCase) : super(NoteInitial());

  final UpdateNoteUseCase updateNoteUseCase;

  void updateNote({
    required String title,
    required String description,
    required String docId,
  }) async {
    emit(NoteLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    try {
      await updateNoteUseCase.execute(
        title: title,
        description: description,
        docId: docId,
      );
      await Future.delayed(const Duration(seconds: 3));
      emit(NoteDeletedState());
    } catch (e) {
      emit(NoteErrorState(e.toString()));
    }
  }
}
