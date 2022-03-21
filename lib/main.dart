import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_app/device/constants/app_constants.dart';
import 'package:square_app/utils/navigation/navigation_services.dart';

import 'utils/navigation/enum/enum_navigate.dart';
import 'utils/navigation/navigator_route_services.dart';

void main() {
  runApp(EasyLocalization(
      startLocale: LocaleConstants.TR_LOCALE,
      supportedLocales: const [LocaleConstants.EN_LOCALE, LocaleConstants.TR_LOCALE],
      path: LocaleConstants.LANG_PATH,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      navigatorKey: NavigationServices.instance!.navigatorKey,
      onGenerateRoute: (settings) => NavigatorRouteServices.onRouteGenarete(settings),
      initialRoute: EnumRoute.SPLASH.name,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
