class LottieConstants {
  static LottieConstants? _instance;

  static LottieConstants? get instance {
    _instance ??= LottieConstants._init();
    return _instance;
  }

  LottieConstants._init();

  // ignore: non_constant_identifier_names
  final String SPLASH = "assets/lottie/maths_splash.json";

  // ignore: non_constant_identifier_names
  final String SEVYESECME = "assets/lottie/maths_sevye_secme.json";

  // ignore: non_constant_identifier_names
  final String SEVYESECME2 = "assets/lottie/maths_sevye_secme2.json";

  // ignore: non_constant_identifier_names
  final String DRAWER_LOTTIE = "assets/lottie/drawer_lottie.json";
}

class AssetsConstants {
  static AssetsConstants? _instance;

  static AssetsConstants? get instance {
    return _instance ??= AssetsConstants._init();
  }

  AssetsConstants._init();

  // ignore: non_constant_identifier_names
  final String ONBOARD_SVG1 = "assets/images/svg/onboard_1.svg";
  // ignore: non_constant_identifier_names
  final String ONBOARD_SVG2 = "assets/images/svg/onboard_2.svg";
}
