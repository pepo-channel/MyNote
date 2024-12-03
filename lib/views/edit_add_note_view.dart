import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mynote/consts/consts.dart';
import 'package:mynote/cubits/cubit/note_cubit.dart';
import 'package:mynote/customs/custom_snackbar.dart';
import 'package:mynote/models/note_model.dart';
import '../customs/custom_icon_button.dart';
import '../widgets/color_list_biulder.dart';

class EditAddNoteView extends StatefulWidget {
  const EditAddNoteView({
    super.key,
    this.subtitle,
    this.subcontent,
    this.subcolor,
  });

  final String? subtitle;
  final String? subcontent;
  final Color? subcolor;

  @override
  State<EditAddNoteView> createState() => _EditAddNoteViewState();
}

class _EditAddNoteViewState extends State<EditAddNoteView> {
  GlobalKey<FormState> formkey = GlobalKey();
  String? title;
  String? content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        // use it to set fixed height for app bar
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          // padding form top
          padding: const EdgeInsets.only(top: 20),
          child: AppBar(
            // Note app bar details page
            automaticallyImplyLeading: false, // remove auto arrow back
            title: Row(
              // row has back icon and done icon
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                  // back icon
                  iconbutton: Icons.arrow_back_ios_new,
                  onpressed: () {
                    Navigator.pop(context);
                  },
                ),
                CustomIconButton(
                  // done icon
                  iconbutton: Icons.done,
                  onpressed: () {
                    // save note in box
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save(); // save values from field
                      DateTime currentdate = DateTime.now();
                      String formatdate =
                          DateFormat('EEEE, MMMM d, y').format(currentdate);
                      NoteModel note = NoteModel(
                          // save values from field in notemodel
                          title: title!,
                          content: content!,
                          date: formatdate); // convert datetime tostring
                      if (widget.subtitle?.isEmpty ?? true) {
                        // chick if subtitle is empty it will add new note
                        BlocProvider.of<NoteCubit>(context)
                            .AddNote(note); // add note to hive box
                        CustomSnackBar(context, 'Done');
                      } else {
                        // else if subtitle is not empty it will edit this note
                        BlocProvider.of<NoteCubit>(context)
                            .UpdateNote(note, widget.subtitle!);
                        CustomSnackBar(context, 'edit success');
                      }
                      // remove all screens and push homeview
                      Navigator.pushNamedAndRemoveUntil(context, kPushHomeView,
                          (Route<dynamic> route) => false);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          // form has column with two textfrom field
          key: formkey,
          child: Column(
            // column has two text field
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(
                          // padding
                          top: 16,
                          bottom: 16,
                          right: 32,
                        ),
                        child: TextFormField(
                          // text field for note title
                          initialValue:
                              widget.subtitle, // initail title if it exist
                          validator: (value) {
                            // check if field is empty
                            if (value?.isEmpty ?? true) {
                              return 'required field';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            // save a title in value
                            title = newValue;
                          },
                          cursorHeight: 25,
                          maxLines: null,
                          minLines: null,
                          style: const TextStyle(
                              fontSize:
                                  25), // here custom font size for note title
                          decoration: const InputDecoration(
                            // decoration style
                            hintText: 'Title',
                            hintStyle: TextStyle(fontSize: 25),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverFillRemaining(
                      child: Container(
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            TextFormField(
                              // text field for note content
                              initialValue: widget
                                  .subcontent, // initial content if it exit
                              validator: (value) {
                                // check is content is empty
                                if (value?.isEmpty ?? true) {
                                  return 'required field';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                // save content in value
                                content = newValue;
                              },
                              maxLines: null,
                              minLines: null,
                              decoration: const InputDecoration(
                                // decoration style
                                hintText: 'Text...',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ColorListBiulder(
                subcolor: widget.subcolor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
