import 'package:flutter/material.dart';
import 'package:mynote/customs/custom_snackbar.dart';
import 'package:mynote/models/note_model.dart';
import 'package:mynote/views/details_note_view.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({
    super.key,
    required this.note,
  });

  final NoteModel note;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // note item // use padding around container => don't use padding in page
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        // column has note and date
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () { // push details view
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailsNoteView(
                  title: widget.note.title,
                  content: widget.note.content,
                  color: widget.note.color,
                );
              }));
            },
            onLongPress: () { // delete note
              widget.note.delete();
              CustomSnackBar(context, 'deleted');
              setState(() {});
            },
            child: Container(
              // note box
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.note.color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                // container content
                widget.note.title, // get note content form value
                style: const TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
          ),
          Align(
              // date text here
              alignment: Alignment.centerLeft,
              child: Text(
                widget.note.date, // get note date from value
                style: const TextStyle(color: Colors.grey),
              )),
        ],
      ),
    );
  }
}
