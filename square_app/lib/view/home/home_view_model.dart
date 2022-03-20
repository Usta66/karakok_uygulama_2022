

import 'package:flutter/material.dart';
import 'package:square_app/utils/navigation/enum/enum_navigate.dart';
import 'package:square_app/utils/navigation/navigation_services.dart';



class HomeViewModel extends ChangeNotifier {
  navigateZor() {
    NavigationServices.instance!.navigate(EnumRoute.ZOR);
  }

  navigateOrta() {
    NavigationServices.instance!.navigate(EnumRoute.ORTA);
  }

  navigateKolay() {
    NavigationServices.instance!.navigate(EnumRoute.KOLAY);
  }
}
