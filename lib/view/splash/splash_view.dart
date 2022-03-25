import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../base/view/base_view.dart';
import '../../device/constants/app_constants.dart';
import 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key, required this.viewModel}) : super(key: key);
  final SplashViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel.control();
    return BaseView<SplashViewModel>(
        viewModel: viewModel,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(LottieConstants.instance!.SPLASH),
              ],
            ),
          ),
        ));
  }
}
