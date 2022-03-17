import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.height,
    required this.width, required this.raduis,
  }) : super(key: key);
  final Function() onPressed;
  final String title;
  final double height;
  final double width;
  final double raduis;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(width, height)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(raduis)))));
  }
}
