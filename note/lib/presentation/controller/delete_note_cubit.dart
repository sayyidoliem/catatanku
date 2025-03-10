import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/usecase/delete_note_usecase.dart';
import 'package:note/presentation/controller/note_state.dart';

class DeleteNoteCubit extends Cubit<NoteState> {
  DeleteNoteCubit(this.deleteNoteUseCase) : super(NoteInitial());

  final DeleteNoteUseCase deleteNoteUseCase;

  void deleteNote({required String docId}) async {
    emit(NoteLoadingState());
    try {
      await deleteNoteUseCase.execute(docId: docId);
      emit(NoteDeletedState());
    } catch (e) {
      emit(NoteErrorState(e.toString()));
    }
  }
}
