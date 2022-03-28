import 'dart:math';

import 'package:flutter/material.dart';

import '../../components/locale_text.dart';
import '../../init/locale_keys.g.dart';
import '../../init/ortak_fonksiyonlar.dart';
import '../../model/karekok_model.dart';
import '../../utils/extensions/extensions.dart';
import '../../utils/navigation/enum/enum_navigate.dart';
import '../../utils/navigation/navigation_services.dart';

class KolayViewModel extends ChangeNotifier {
  late int oyunSuresi;
  final int oyunSuresiSabit = 60;
  final int oyunEkSure = 10;
  late int puan;
  late int a;
  late int b;

  late TextEditingController sureController;
  late TextEditingController puanController;
  late TextEditingController kareKokController;
  late GlobalKey<ScaffoldState> scaffoldKey;

  late KaraKokModel model;

  // ignore: avoid_init_to_null
  late int? birinciSecilen = null;

  List<KaraKokModel> modelList = [];

  List<int> bSabitList = [2, 3, 5, 6, 7, 10];

  List<int> bList = [2, 3, 5, 6, 7, 8, 10, 12, 18, 20, 24, 28, 32, 40, 45, 48, 50, 54, 72, 75, 80, 90, 98, 108, 125, 180, 300, 500, 600];

  KolayViewModel() {
    scaffoldKey = GlobalKey<ScaffoldState>();

    oyunSuresi = oyunSuresiSabit;
    puan = 0;
    sureController = TextEditingController(text: oyunSuresi.toString());
    puanController = TextEditingController(text: puan.toString());
    modelListDoldur();

    geriSayimSayaci();

    kareKokController = TextEditingController(text: "$a√$b");
  }

  modelListDoldur() {
    a = Random().nextInt(5) + 1;
    b = bList[Random().nextInt(bList.length)];

    for (var i = 0; i < 6; i++) {
      model = KaraKokModel(a: Random().nextInt(5) + 1, b: bSabitList[i]);

      modelList.add(model);
    }
  }

  renkDegistir(Color color) {
    modelList[birinciSecilen!].renk = color;
    notifyListeners();
  }

  void puanArtir() {
    puan++;
    puanController.text = puan.toString();
  }

  oyunSuresiArtir() {
    oyunSuresi = oyunSuresi + oyunEkSure;

    if (oyunSuresi > oyunSuresiSabit) {
      oyunSuresi = oyunSuresiSabit;
    }
    sureController.text = oyunSuresi.toString();
  }

  void karekokDegistir() {
    a = Random().nextInt(5) + 1;
    b = bList[Random().nextInt(bList.length)];

    kareKokController.text = "$a√$b";
  }

  navigateHome() {
    NavigationServices.instance!.navigateToReset(EnumRoute.HOME);
  }

  bool dogalSayimi() {
    return OrtakFonksiyonlar().dogalSayimi(modelList[birinciSecilen!].b, b);
  }

  Future<void> geriSayimSayaci() async {
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
}
