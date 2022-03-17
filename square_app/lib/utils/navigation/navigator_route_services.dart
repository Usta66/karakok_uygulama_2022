import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:square_app/view/home/home_view.dart';
import 'package:square_app/view/home/home_view_model.dart';
import 'package:square_app/view/onboard/onboard_view.dart';
import 'package:square_app/view/onboard/onboard_view_model.dart';
import 'package:square_app/view/splash/splash_view.dart';
import 'package:square_app/view/splash/splash_view_model.dart';

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
    }
  }

  static MaterialPageRoute _navigateToDeafult(Widget page) {
    return MaterialPageRoute(builder: (context) => page);
  }

  static _navigateToScaleDeafult<T extends ChangeNotifier>(
      T viewModel, Widget page) {
    return ScaleRoute<T>(page, viewModel);
  }
}
