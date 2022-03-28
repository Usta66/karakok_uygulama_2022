// ignore_for_file: unused_element

import 'package:flutter/material.dart';

import '../../view/home/home_view.dart';
import '../../view/home/home_view_model.dart';
import '../../view/kolay/kolay_view.dart';
import '../../view/kolay/kolay_view_model.dart';
import '../../view/onboard/onboard_view.dart';
import '../../view/onboard/onboard_view_model.dart';
import '../../view/orta_zor/orta_zor_view.dart';
import '../../view/orta_zor/orta_zor_view_model.dart';
import '../../view/splash/splash_view.dart';
import '../../view/splash/splash_view_model.dart';
import 'transition/scale_transition.dart';

class NavigatorRouteServices {
  NavigatorRouteServices._init();
  static Route<dynamic>? onRouteGenarete(RouteSettings settings) {
    switch (settings.name) {
      case "SPLASH":
        return _navigateToDeafult(SplashView(viewModel: SplashViewModel()));
      case "ONBOARD":
        return _navigateToDeafult(OnboardView(viewModel: OnboardViewModel()));

      case "HOME":
        return _navigateToDeafult(HomeView(viewModel: HomeViewModel()));

      case "ZOR":
        return _navigateToDeafult(OrtaZorView(viewModel: OrtaZorViewModel.zor()));

      case "ORTA":
        return _navigateToDeafult(OrtaZorView(viewModel: OrtaZorViewModel.orta()));

      case "KOLAY":
        return _navigateToDeafult(KolayView(viewModel: KolayViewModel()));
    }
    return null;
  }

  static MaterialPageRoute _navigateToDeafult(Widget page) {
    return MaterialPageRoute(builder: (context) => page);
  }

  static _navigateToScaleDeafult(Widget page) {
    return ScaleRoute(page);
  }
}
