import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);
  final Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(context.width * 0.6, context.height * 0.07)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.highValue)))));
  }
}
