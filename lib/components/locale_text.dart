import 'package:flutter/material.dart';
import 'package:square_app/utils/extensions/extensions.dart';

class LocaleText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const LocaleText({Key? key, required this.text, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text.locale, style: style);
  }
}
