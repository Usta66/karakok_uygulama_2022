import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'device/constants/app_constants.dart';
import 'utils/navigation/navigation_services.dart';
import 'utils/navigation/enum/enum_navigate.dart';
import 'utils/navigation/navigator_route_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: const [LocaleConstants.EN_LOCALE, LocaleConstants.TR_LOCALE], path: LocaleConstants.LANG_PATH, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextTheme textThemeBase = Theme.of(context).textTheme;
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: TextTheme(
            bodyText1: textThemeBase.bodyText1!.copyWith(color: Colors.deepPurpleAccent, fontSize: 15, fontStyle: FontStyle.italic),
          )),
      navigatorKey: NavigationServices.instance!.navigatorKey,
      onGenerateRoute: (settings) => NavigatorRouteServices.onRouteGenarete(settings),
      initialRoute: EnumRoute.SPLASH.name,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
