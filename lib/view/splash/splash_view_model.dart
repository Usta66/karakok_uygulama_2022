import 'package:flutter/material.dart';
import '../../init/cache/enum_preferences_keys.dart';
import '../../utils/navigation/enum/enum_navigate.dart';
import '../../utils/navigation/navigation_services.dart';

import '../../init/cache/locale_maneger.dart';

class SplashViewModel extends ChangeNotifier {
  control() async {
    await LocaleManeger.prefrencesInit();
    await Future.delayed(const Duration(milliseconds: 5600));
    navigate();
  }

  navigate() async {
    bool? isOpen = LocaleManeger.instance.getBoolValue(EnumPreferencesKeys.ISFIRSTOPEN);

    if (isOpen == null || isOpen == false) {
      LocaleManeger.instance.setBoolValue(EnumPreferencesKeys.ISFIRSTOPEN, true);
      NavigationServices.instance!.navigate(EnumRoute.ONBOARD);
    } else {
      NavigationServices.instance?.navigateToReset(EnumRoute.HOME);
    }
  }
}
