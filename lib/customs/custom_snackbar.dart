import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

CustomSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    ),
    backgroundColor: const Color(0xff3B3B3B),
  ));
}
