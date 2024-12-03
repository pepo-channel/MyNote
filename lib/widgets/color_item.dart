import 'package:flutter/material.dart';

class ColorItem extends StatefulWidget {
  const ColorItem({
    super.key,
    required this.isactive,
    required this.color,
  });
  final bool isactive;
  final Color color;

  @override
  State<ColorItem> createState() => _ColorItemState();
}

class _ColorItemState extends State<ColorItem> {
  @override
  Widget build(BuildContext context) {
    return widget.isactive
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: widget.color,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: widget.color,
            ),
          );
  }
}
