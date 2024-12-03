import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:mynote/consts/consts.dart';
import 'package:mynote/models/note_model.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  Color newcolor = const Color(0xffFD99FF);

  AddNote(NoteModel note) {
    note.color = newcolor;
    Box<NoteModel> notebox = Hive.box<NoteModel>(knotebox);
    notebox.add(note);
    emit(NoteSuccess());
  }

  List<NoteModel> GetNotes() {
    emit(NoteInitial());
    Box<NoteModel> notebox = Hive.box<NoteModel>(knotebox);
    emit(NoteSuccess());
    return notebox.values.toList();
  }

  DeleteNote(NoteModel note) {
    Box<NoteModel> notebox = Hive.box<NoteModel>(knotebox);
    notebox.delete(note);
  }

  UpdateNote(NoteModel note, String oldtitle) {
    note.color = newcolor;
    Box<NoteModel> notebox = Hive.box<NoteModel>(knotebox);
    int keyindex = -1;

    for (int i = 0; i <= notebox.length; i++) {
      NoteModel? oldnote = notebox.getAt(i);
      if (oldnote != null && oldtitle == oldnote.title) {
        keyindex = i;
        break;
      }
    }

    if (keyindex != -1) {
      notebox.putAt(keyindex, note);
    }
  }
}
