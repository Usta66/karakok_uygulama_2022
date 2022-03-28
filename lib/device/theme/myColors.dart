// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyColors {
  static MyColors? _instance;

  static MyColors? get instance {
    return _instance ??= MyColors._init();
  }

  MyColors._init();

  Color seciliRenk = const Color(0xFFC5CAE9);
  Color normal = const Color(0xFFB2DFDB);
  Color dogru = const Color(0xFF4caf50);
  Color yanlis = const Color(0xFFb71c1c);
  Color zamanVeSkor = const Color(0xFFFFD900);
}
