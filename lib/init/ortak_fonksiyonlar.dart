import 'dart:math';

class OrtakFonksiyonlar {
  bool dogalSayimi(int say1, int say2) {
    double c = sqrt(say1.toDouble() * say2.toDouble());

    if (c - c.toInt() == 0) {
      return true;
    } else {
      return false;
    }
  }
}
