import 'package:flutter/material.dart';
import 'package:square_app/init/cache/enum_preferences_keys.dart';
import 'package:square_app/utils/navigation/enum/enum_navigate.dart';
import 'package:square_app/utils/navigation/navigation_services.dart';

import '../../init/cache/locale_maneger.dart';

class SplashViewModel extends ChangeNotifier {
  control() async {

    await Future.delayed(const Duration(milliseconds: 5600));

    navigate();
  }

  navigate() async {

 await LocaleManeger.prefrencesInit();
bool? isOpen = LocaleManeger.instance.getBoolValue(EnumPreferencesKeys.ISFIRSTOPEN);

 if (isOpen == null || isOpen == false) {
      LocaleManeger.instance.setBoolValue(EnumPreferencesKeys.ISFIRSTOPEN, true);
    NavigationServices.instance!.navigate(EnumRoute.ONBOARD);
    } else {
      NavigationServices.instance?.navigateToReset(EnumRoute.HOME);
    }

    
  }
}
