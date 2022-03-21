import 'dart:math';

import 'package:flutter/material.dart';

import '../../model/karekok_model.dart';
import '../../utils/navigation/enum/enum_navigate.dart';
import '../../utils/navigation/navigation_services.dart';

class KolayViewModel extends ChangeNotifier {
  Color seciliRenk = const Color(0xFFC5CAE9);
  Color normal = const Color(0xFFB2DFDB);
  Color dogru = const Color(0xFF4caf50);
  Color yanlis = const Color(0xFFb71c1c);
  Color zamanVeSkor = const Color(0xFFFFD900);

  late int oyunSuresi;
  final int oyunSuresiSabit = 60;
  final int oyunEkSure = 10;
  late int puan;
  late int a;
  late int b;

  late TextEditingController sureController;
  late TextEditingController puanController;
  late TextEditingController kareKokController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late KaraKokModel model;

  // ignore: avoid_init_to_null
  late int? birinciSecilen = null;
  // int ikinciSecilen;
  List<KaraKokModel> modelList = [];

  List<int> bSabitList = [2, 3, 5, 6, 7, 10];

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

  KolayViewModel() {
    oyunSuresi = oyunSuresiSabit;
    puan = 0;
    sureController = TextEditingController(text: oyunSuresi.toString());
    puanController = TextEditingController(text: puan.toString());

    a = Random().nextInt(5) + 1;
    b = bList[Random().nextInt(bList.length)];

    for (var i = 0; i < 6; i++) {
      model = KaraKokModel(a: Random().nextInt(5) + 1, b: bSabitList[i]);

      modelList.add(model);
    }
    geriSayimSayaci();

    kareKokController = TextEditingController(text: "$a√$b");
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
            title: Center(child: Text("Tebrikler $puan Puan Aldınız")),
            content: TextButton(
              child: const Text("Yeni Oyun"),
              onPressed: () {
                NavigationServices.instance!.navigateToReset(EnumRoute.KOLAY);
              },
            ),
          );
        },
      );
    }
  }

  navigateHome() {
    NavigationServices.instance!.navigateToReset(EnumRoute.HOME);
  }
}
