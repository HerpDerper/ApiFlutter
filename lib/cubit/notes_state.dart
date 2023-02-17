part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class UpdateNotes extends NotesState {
  final List<Note> notes;

  UpdateNotes(this.notes);
}

class ClearNotes extends NotesState {
  final List<Note> notes;

  ClearNotes(this.notes);
}
