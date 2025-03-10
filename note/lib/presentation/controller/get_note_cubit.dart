import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/usecase/get_note_usecase.dart';
import 'package:note/presentation/controller/note_state.dart';

class GetNoteCubit extends Cubit<NoteState> {
  GetNoteCubit(this.getNotesUseCase) : super(NoteInitial());

  final GetNotesUseCase getNotesUseCase;

 void fetchNotes(String userUid) {
    emit(NoteLoadingState());
    getNotesUseCase.execute(userUid).listen((notes) {
      emit(NoteLoadedState(notes));
    });
  }
}
