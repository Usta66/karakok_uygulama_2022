import 'dart:math';
import 'package:flutter/material.dart';
import 'package:square_app/utils/extensions/extensions.dart';
import '../../components/locale_text.dart';
import '../../init/locale_keys.g.dart';
import '../../init/ortak_fonksiyonlar.dart';
import '../../model/karekok_model.dart';
import '../../utils/navigation/enum/enum_navigate.dart';
import '../../utils/navigation/navigation_services.dart';

class OrtaZorViewModel extends ChangeNotifier {
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
  List<int> bList = [2, 3, 5, 6, 7, 8, 10, 12, 18, 20, 24, 28, 32, 40, 45, 48, 50, 54, 72, 75, 80, 90, 98, 108, 125, 180, 300, 500, 600];

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

  bool dogalSayimi() {
    return OrtakFonksiyonlar().dogalSayimi(modelList[birinciSecilen!].b, modelList[ikinciSecilen!].b);
  }

  void yeniSayiEkle() {
    modelList.removeAt(birinciSecilen!);
    modelList.insert(birinciSecilen!, KaraKokModel(a: Random().nextInt(5) + 1, b: bList[Random().nextInt(bList.length)]));

    modelList.removeAt(ikinciSecilen!);

    modelList.insert(ikinciSecilen!, KaraKokModel(a: Random().nextInt(5) + 1, b: bList[Random().nextInt(bList.length)]));
  }

  navigateHome() {
    NavigationServices.instance!.navigateToReset(EnumRoute.HOME);
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
