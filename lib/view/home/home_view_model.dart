import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/navigation/enum/enum_navigate.dart';
import '../../utils/navigation/navigation_services.dart';

import '../../device/constants/app_constants.dart';

class HomeViewModel extends ChangeNotifier {
  late bool isLangEn;

  navigateZor() {
    NavigationServices.instance!.navigate(EnumRoute.ZOR);
  }

  localeBelirle(BuildContext context) {
    if (context.locale.languageCode == "en") {
      isLangEn = true;
    } else {
      isLangEn = false;
    }
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

  changeLang(BuildContext context) async {
    if (isLangEn) {
      await context.setLocale(LocaleConstants.EN_LOCALE);
    } else {
      await context.setLocale(LocaleConstants.TR_LOCALE);
    }
  }
}
