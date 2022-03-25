import 'package:flutter/material.dart';
import '../../utils/extensions/extensions.dart';

import '../../device/constants/app_constants.dart';
import '../../init/locale_keys.g.dart';
import 'onboard_model.dart';

class OnboardViewModel extends ChangeNotifier {
  List<OnboardModel> onboardItems = [];
  int curruntIndex = 0;
  OnboardViewModel() {
    init();
  }

  void changeCurrentIndex(int value) {
    curruntIndex = value;
    notifyListeners();
  }

  void init() {
    onboardItems.add(OnboardModel(
        title: LocaleKeys.onboard_title1.locale,
        description: LocaleKeys.onboard_subTitle1.locale,
        imagePath: AssetsConstants.instance!.ONBOARD_SVG1));

    onboardItems.add(OnboardModel(
        title: LocaleKeys.onboard_title2.locale,
        description: LocaleKeys.onboard_subTitle2.locale,
        imagePath: AssetsConstants.instance!.ONBOARD_SVG2));

    onboardItems.add(OnboardModel(
        title: LocaleKeys.onboard_title3.locale,
        description: LocaleKeys.onboard_subTitle3.locale,
        imagePath: AssetsConstants.instance!.ONBOARD_SVG2));
  }
}
