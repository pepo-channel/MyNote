import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynote/cubits/cubit/note_cubit.dart';
import 'package:mynote/widgets/color_item.dart';

class ColorListBiulder extends StatefulWidget {
  const ColorListBiulder({
    super.key,
    this.subcolor,
  });

  final Color? subcolor;

  @override
  State<ColorListBiulder> createState() => _ColorListBiulderState();
}

class _ColorListBiulderState extends State<ColorListBiulder> {
  int currentindex = 0;
  List<Color> colors = [
    const Color(0xffFD99FF),
    const Color(0xffFF9E9E),
    const Color(0xff91F48F),
    const Color(0xffFFF599),
    const Color(0xff9EFFFF),
    const Color(0xffB69CFF),
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.subcolor != null) {
      // check if it coming to edit so subcolor != null
      // then i will pick old color
      // else use first color in list
      currentindex =
          colors.indexOf(BlocProvider.of<NoteCubit>(context).newcolor);
    }
    return SizedBox(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                currentindex = index;
                BlocProvider.of<NoteCubit>(context).newcolor = colors[index];
                setState(() {});
              },
              child: ColorItem(
                isactive: currentindex == index,
                color: colors[index],
              ),
            );
          }),
    );
  }
}
