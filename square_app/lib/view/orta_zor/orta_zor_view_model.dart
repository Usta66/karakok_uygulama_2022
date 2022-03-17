import 'dart:math';

import 'package:flutter/material.dart';

import '../../model/karekok_model.dart';

class OrtaZorViewModel extends ChangeNotifier{

  Color seciliRenk = const Color(0xFFC5CAE9);
  Color normal = const Color(0xFFB2DFDB);
  Color dogru = const Color(0xFF4caf50);
  Color yanlis = const Color(0xFFb71c1c);
  int oyunSuresi = 60;
  int puan = 0;

  late TextEditingController sureController;

  late KaraKokModel model;
  late int index;
  int? birinciSecilen;
  int? ikinciSecilen;

  List<KaraKokModel> modelList = [];
  List<int> bTemp = [];
  List<int> bList = [
    2,
    3,
    5,
    6,
    7,
    8,
    10,
    12,
    18,
    20,
    24,
    28,
    32,
    40,
    45,
    48,
    50,
    54,
    72,
    75,
    80,
    90,
    98,
    108,
    125,
    180,
    300,
    500,
    600
  ];

  HomeViewModel() {
    sureController = TextEditingController(text: oyunSuresi.toString());
    geriSayimSayaci();
    for (int i = 0; i < 16;) {
      index = Random().nextInt(bList.length);
      if (!bTemp.contains(bList[index])) {
        bTemp.add(bList[index]);
        i++;
      }
    }

    for (var i = 0; i < 16; i++) {
      //index = Random().nextInt(bList.length);

      model = KaraKokModel(a: Random().nextInt(5) + 1, b: bTemp[i]);

      modelList.add(model);
    }
  }

  renkDegistir(Color color, int i) {
    modelList[i].renk = color;
    notifyListeners();
  }

  Future<void> geriSayimSayaci() async {
    for (int i = 0; oyunSuresi > 0; i++) {
      await Future.delayed(const Duration(seconds: 1));
      oyunSuresi--;
      sureController.text = oyunSuresi.toString();
      //notifyListeners();
    }
  }

  bool dogalSayimi(int say1, int say2) {
    double c = sqrt(say1.toDouble() * say2.toDouble());

    if (c - c.toInt() == 0) {
      return true;
    } else {
      return false;
    }
  }






}