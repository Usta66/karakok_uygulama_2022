import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'locale_text.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);
  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: LocaleText(text: text),
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(context.width * 0.6, context.height * 0.07)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.highValue)))));
  }
}
