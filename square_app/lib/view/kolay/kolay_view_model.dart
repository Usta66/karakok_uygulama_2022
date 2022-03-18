import 'dart:math';

import 'package:flutter/material.dart';

import '../../model/karekok_model.dart';
import '../../utils/navigation/enum/enum_navigate.dart';
import '../../utils/navigation/navigation_services.dart';

class KolayViewModel extends ChangeNotifier {
  Color seciliRenk = Color(0xFFC5CAE9);
  Color normal = Color(0xFFB2DFDB);
  Color dogru = Color(0xFF4caf50);
  Color yanlis = Colors.red;

  late int oyunSuresi;
  late int puan;
  late int a;
  late int b;

  late TextEditingController sureController;
  late TextEditingController puanController;
  late TextEditingController kareKokController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late KaraKokModel model;

  late int? birinciSecilen = null;
  // int ikinciSecilen;
  List<KaraKokModel> modelList = [];

  List<int> bSabitList = [2, 3, 5, 6, 7, 10];

  List<int> bList = [2, 3, 5, 6, 7, 8, 10, 12, 18, 20, 24, 28, 32, 40, 45, 48, 50, 54, 72, 75, 80, 90, 98, 108, 125, 180, 300, 500, 600];

  KolayViewModel() {
    oyunSuresi = 60;
    puan = 0;
    sureController = TextEditingController(text: oyunSuresi.toString());
    puanController = TextEditingController(text: puan.toString());

    a = Random().nextInt(5) + 1;
    b = bList[Random().nextInt(bList.length)];

    for (var i = 0; i < 6; i++) {
      model = KaraKokModel(a: Random().nextInt(5) + 1, b: bSabitList[i]);

      modelList.add(model);
    }

    kareKokController = TextEditingController(text: "$a√$b");
  }

  renkDegistir(Color color, int i) {
    modelList[i].renk = color;
    notifyListeners();
  }

  void puanArtir() {
    puan++;
    puanController.text = puan.toString();
  }

  oyunSuresiArtir() {
    oyunSuresi = oyunSuresi + 10;

    if (oyunSuresi > 60) {
      oyunSuresi = 60;
    }
    sureController.text = oyunSuresi.toString();
  }

  void karekokDegistir() {
    a = Random().nextInt(5) + 1;
    b = bList[Random().nextInt(bList.length)];

    kareKokController.text = "$a√$b";
  }

  Future<void> geriSayimSayaci(BuildContext context) async {
    for (int i = 0; oyunSuresi > 0; i++) {
      await Future.delayed(const Duration(seconds: 1));
      oyunSuresi--;
      sureController.text = oyunSuresi.toString();

      //notifyListeners();
    }

    if (scaffoldKey.currentContext != null) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text("Tebrikler $puan Puan Aldınız")),
            content: TextButton(
              child: Text("Yeni Oyun"),
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
