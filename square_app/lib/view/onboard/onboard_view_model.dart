import 'package:flutter/material.dart';

import '../../device/constants/app_constants.dart';
import 'onboard_model.dart';

class OnboardViewModel extends ChangeNotifier {
  List<OnboardModel> onboardItems = [];
  int curruntIndex = 0;
  OnboardViewModel() {
    init();
  }

  void changeCurrentIndex(int value) {
    curruntIndex = value;
    notifyListeners();
  }

  void init() {
    onboardItems.add(OnboardModel(
        title: "ÖĞRENCİ TESLİ SİSTEMi",
        description: "Güvenle Çoçuğunuzu Okula Bırakın Alın",
        imagePath: AssetsConstants.instance!.ONBOARD_SVG1));

    onboardItems.add(OnboardModel(
        title: "Okul İdarecileri İçiniz Rahat Olsun",
        description: "Öğrencinin Giriş-Çıkış Saatlerini Kayıt Altına Alın",
        imagePath: AssetsConstants.instance!.ONBOARD_SVG2));

    onboardItems.add(OnboardModel(
        title: "KareKökkkk",
        description: "Öğrencinin Giriş-Çıkış Saatlerini Kayıt Altına Alın",
        imagePath: AssetsConstants.instance!.ONBOARD_SVG2));
  }
}
