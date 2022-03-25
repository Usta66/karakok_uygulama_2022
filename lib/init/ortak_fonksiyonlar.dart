import 'dart:math';
import 'package:flutter/material.dart';
import 'locale_keys.g.dart';
import '../utils/extensions/extensions.dart';

import '../components/locale_text.dart';
import '../utils/navigation/enum/enum_navigate.dart';
import '../utils/navigation/navigation_services.dart';

class OrtakFonksiyonlar {
  static OrtakFonksiyonlar? _instance;

  static OrtakFonksiyonlar? get instance {
    _instance ??= OrtakFonksiyonlar._init();

    return _instance;
  }

  OrtakFonksiyonlar._init();

  bool dogalSayimi(int say1, int say2) {
    double c = sqrt(say1.toDouble() * say2.toDouble());

    if (c - c.toInt() == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> geriSayimSayaci(
      {required int oyunSuresi,
      required TextEditingController sureController,
      required GlobalKey<ScaffoldState> scaffoldKey,
      required int puan}) async {
    for (int i = 0; oyunSuresi > 0; i++) {
      await Future.delayed(const Duration(seconds: 1));
      oyunSuresi--;
      sureController.text = oyunSuresi.toString();
    }
    if (scaffoldKey.currentContext != null) {
      showDialog(
        barrierDismissible: false,
        context: scaffoldKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text("${LocaleKeys.diolog_tebrikler.locale} $puan ${LocaleKeys.diolog_puanAldiniz.locale}")),
            content: TextButton(
              // ignore: prefer_const_constructors
              child: LocaleText(text: LocaleKeys.diolog_yeniOyun),
              onPressed: () {
                NavigationServices.instance!.navigateToReset(EnumRoute.KOLAY);
              },
            ),
          );
        },
      );
    }
  }

  oyunSuresiArtir({required int oyunSuresi, required int oyunEkSure, required oyunSuresiSabit, required TextEditingController sureController}) {
    oyunSuresi = oyunSuresi + oyunEkSure;

    if (oyunSuresi > oyunSuresiSabit) {
      oyunSuresi = oyunSuresiSabit;
    }
    sureController.text = oyunSuresi.toString();
  }

  void puanArtir({required int puan, required TextEditingController puanController}) {
    puan++;
    puanController.text = puan.toString();
  }
}
