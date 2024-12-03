import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynote/consts/consts.dart';
import 'package:mynote/cubits/cubit/note_cubit.dart';
import 'package:mynote/models/note_model.dart';

import '../widgets/note_list_biulder.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NoteCubit>(context).GetNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        // use it to set fixed height for app bar // home view app bar
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          // padding form top
          padding: const EdgeInsets.only(top: 20),
          child: AppBar(
            title: Row(
              // row has app name and search icon
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  // app name
                  'Notes',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  // search icon button
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                  ),
                  style: ButtonStyle(
                      // search icon style
                      backgroundColor:
                          const WidgetStatePropertyAll(Color(0xff3B3B3B)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                      padding:
                          const WidgetStatePropertyAll(EdgeInsets.all(12))),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: IconButton(
        // add icon button
        onPressed: () {
          // push add note <<<
          Navigator.pushNamed(context, kPushAddNoteView);
        },
        icon: const Icon(
          Icons.add,
        ),
        style: ButtonStyle(
            // add icon style
            backgroundColor: const WidgetStatePropertyAll(Color(0xff3B3B3B)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
            padding: const WidgetStatePropertyAll(EdgeInsets.all(12))),
      ),
      body: BlocBuilder<NoteCubit, NoteState>(builder: (context, state) {
        List<NoteModel> notes = BlocProvider.of<NoteCubit>(context).GetNotes();
        if (notes.isEmpty) {
          return Center(
            // if don't notes found
            child: Image.asset(
              'assets/images/home.png',
            ),
          );
        }
        return NoteListBiulder(
          notes: notes,
        );
      }),
    );
  }
}
