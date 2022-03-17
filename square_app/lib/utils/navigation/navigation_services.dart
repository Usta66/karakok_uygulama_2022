import 'package:flutter/material.dart';

import 'enum/enum_navigate.dart';

class NavigationServices {
  static NavigationServices? _instance;

  static NavigationServices? get instance {
    _instance ??= NavigationServices._init();
    return _instance;
  }

  NavigationServices._init();

  get removAllOldRoutes {
    return (Route<dynamic> route) {
      return false;
    };
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "navigator");

  Future navigate(EnumRoute path, {Object? args}) async {
    return await navigatorKey.currentState!.pushNamed(path.name, arguments: args);
  }

  Future navigateToReset(EnumRoute path, {Object? args}) async {
    return await navigatorKey.currentState!.pushNamedAndRemoveUntil(path.name, removAllOldRoutes, arguments: args);
  }
}
