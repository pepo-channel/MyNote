import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.iconbutton,
    this.onpressed,
  });

  final IconData iconbutton;
  final void Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // search icon button
      onPressed: onpressed,
      icon: Icon(
        iconbutton,
        color: Colors.white,
      ),
      style: ButtonStyle(
          // search icon style
          backgroundColor: const WidgetStatePropertyAll(Color(0xff3B3B3B)),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(12))),
    );
  }
}
