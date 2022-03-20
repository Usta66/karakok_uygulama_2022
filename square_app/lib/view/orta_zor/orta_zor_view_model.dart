import 'dart:math';

import 'package:flutter/material.dart';
import 'package:square_app/utils/navigation/enum/enum_navigate.dart';
import 'package:square_app/utils/navigation/navigation_services.dart';

import '../../model/karekok_model.dart';

class OrtaZorViewModel extends ChangeNotifier {
  Color seciliRenk = const Color(0xFFC5CAE9);
  Color normal = const Color(0xFFB2DFDB);
  Color dogru = const Color(0xFF4caf50);
  Color yanlis = const Color(0xFFb71c1c);
  Color zamanVeSkor = const Color(0xFFFFD900);
  late int oyunSuresi;
  final int oyunSuresiSabit = 60;
  final int oyunEkSure = 10;
  late int puan;

  late TextEditingController sureController;
  late TextEditingController puanController;
  bool isZor = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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

  void init() {
    oyunSuresi = oyunSuresiSabit;
    puan = 0;
    sureController = TextEditingController(text: oyunSuresi.toString());
    puanController = TextEditingController(text: puan.toString());
    geriSayimSayaci();
  }

  void zorSevyeIndexSec() {
    for (int i = 0; i < 16;) {
      index = Random().nextInt(bList.length);
      if (!bTemp.contains(bList[index])) {
        bTemp.add(bList[index]);
        i++;
      }
    }
  }

  void modelListesiniDoldurZor() {
    for (var i = 0; i < 16; i++) {
      //index = Random().nextInt(bList.length);

      model = KaraKokModel(a: Random().nextInt(5) + 1, b: bTemp[i]);

      modelList.add(model);
    }
  }

  void modelListesiniDoldurOrta() {
    for (var i = 0; i < 16; i++) {
      index = Random().nextInt(bList.length);

      model = KaraKokModel(a: Random().nextInt(5) + 1, b: bList[index]);

      modelList.add(model);
    }
  }

  OrtaZorViewModel.zor() {
    isZor = true;
    init();
    zorSevyeIndexSec();
    modelListesiniDoldurZor();
  }

  OrtaZorViewModel.orta() {
    init();

    modelListesiniDoldurOrta();
  }

  void renkDegistir(Color color, int i) {
    modelList[i].renk = color;
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
                if (isZor) {
                  NavigationServices.instance!.navigateToReset(EnumRoute.ZOR);
                } else {
                  NavigationServices.instance!.navigateToReset(EnumRoute.ORTA);
                }
              },
            ),
          );
        },
      );
    }
  }

  void yeniSayiEkle() {
    modelList.removeAt(birinciSecilen!);
    modelList.insert(
        birinciSecilen!,
        KaraKokModel(
            a: Random().nextInt(5) + 1,
            b: bList[Random().nextInt(bList.length)]));

    modelList.removeAt(ikinciSecilen!);

    modelList.insert(
        ikinciSecilen!,
        KaraKokModel(
            a: Random().nextInt(5) + 1,
            b: bList[Random().nextInt(bList.length)]));
  }

  navigateHome() {
    NavigationServices.instance!.navigateToReset(EnumRoute.HOME);
  }
}
