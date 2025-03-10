import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoadingState extends NoteState {}

class NoteAddedState extends NoteState {}

class NoteUpdatedState extends NoteState {}

class NoteDeletedState extends NoteState {}

class NoteLoadedState extends NoteState {
  final QuerySnapshot notes;

  const NoteLoadedState(this.notes);
}

class NoteErrorState extends NoteState {
  final String message;

  const NoteErrorState(this.message);
}