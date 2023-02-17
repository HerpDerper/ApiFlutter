import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../models/note.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  List<Note> notes = [];

  void setNotes(List<Note> notes) {
    this.notes = notes;
    emit(UpdateNotes(notes));
  }

  void updateNotes(Note note) {
    notes.add(note);
    emit(UpdateNotes(notes));
  }

  void deleteNote(int index) {
    notes.removeAt(index);
    emit(UpdateNotes(notes));
  }

  void clearNotes() {
    notes.clear();
    emit(ClearNotes(notes));
  }
}
