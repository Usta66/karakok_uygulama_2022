import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_app/utils/navigation/enum/enum_navigate.dart';
import 'package:square_app/utils/navigation/navigation_services.dart';

import '../../device/constants/app_constants.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLangEn = false;

  bool get isLangEn => _isLangEn;

  set isLangEn(bool isLangEn) {
    _isLangEn = isLangEn;
    notifyListeners();
  }

  navigateZor() {
    NavigationServices.instance!.navigate(EnumRoute.ZOR);
  }

  navigateOrta() {
    NavigationServices.instance!.navigate(EnumRoute.ORTA);
  }

  navigateKolay() {
    NavigationServices.instance!.navigate(EnumRoute.KOLAY);
  }

  navigateOnboar() {
    NavigationServices.instance!.navigate(EnumRoute.ONBOARD);
  }

  changeLang(BuildContext context) {
    if (isLangEn) {
      context.setLocale(LocaleConstants.EN_LOCALE);
    } else {
      context.setLocale(LocaleConstants.TR_LOCALE);
    }

    notifyListeners();
  }
}
