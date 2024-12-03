import 'package:flutter/material.dart';
import 'package:mynote/models/note_model.dart';

import 'note_item.dart';

class NoteListBiulder extends StatelessWidget {
  const NoteListBiulder({
    super.key,
    required this.notes,
  });

  final List<NoteModel> notes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (biulder, index) {
        return NoteItem(
          note: notes[index], // give note to note item
        );
      },
      itemCount: notes.length,
    );
  }
}
