import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mynote/consts/consts.dart';
import 'package:mynote/cubits/cubit/note_cubit.dart';
import 'package:mynote/models/note_model.dart';
import 'package:mynote/views/details_note_view.dart';
import 'package:mynote/views/edit_add_note_view.dart';
import 'package:mynote/views/home_view.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(knotebox);
  runApp(const Mynote());
}

class Mynote extends StatelessWidget {
  const Mynote({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider( // give access for note cubit to all app << try to handle this if it possible
      create: (context) => NoteCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: { // to use pushNamed
          kPushHomeView: (context) => const HomeView(),
          kPushNoteDetailsView: (context) => const DetailsNoteView(),
          kPushAddNoteView: (context) => const EditAddNoteView(),
          kPushEditNoteView: (context) => const EditAddNoteView(),
        },
        theme: ThemeData(
            // here i put font family and dark mode
            brightness: Brightness.dark,
            fontFamily: 'Nunito'),
        home: const HomeView(),
      ),
    );
  }
}
