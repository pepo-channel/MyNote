import 'package:flutter/material.dart';
import 'package:mynote/views/edit_add_note_view.dart';
import '../customs/custom_icon_button.dart';

class DetailsNoteView extends StatelessWidget {
  const DetailsNoteView({
    super.key,
    this.title,
    this.content, this.color,
  });

  final String? title;
  final String? content;
  final Color? color;

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
              // row has app name and search icon
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
                  // Edit icon
                  iconbutton: Icons.edit,
                  onpressed: () {
                    // go to edit view with title and content
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EditAddNoteView(
                        subtitle: title,
                        subcontent: content,
                        subcolor: color,
                      );
                    }));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // title note
              padding: const EdgeInsets.only(
                // padding
                top: 16,
                bottom: 16,
                right: 32,
              ),
              child: Text(
                // note title content
                title ?? '', // get title from value
                maxLines: 3,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 1.2,
                  height: 1.5,
                ),
              ),
            ),
            Expanded(
                // use list view to content of note
                child: ListView(
              children: [
                Text(content ?? '') // get content from value
              ],
            ))
          ],
        ),
      ),
    );
  }
}
