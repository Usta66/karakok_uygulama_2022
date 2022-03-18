import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:square_app/components/my_button.dart';
import 'package:square_app/device/constants/app_constants.dart';
import 'package:square_app/view/home/home_view_model.dart';
import 'package:kartal/kartal.dart';
import '../../base/view/base_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.viewModel}) : super(key: key);
  final HomeViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: viewModel,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                accountName: const Text(
                  "Karekök Uygulaması",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                accountEmail: const Text(
                  "Esma ASLAN KARABACAK\nesmaaslan06@gmail.com",
                  style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 15, fontStyle: FontStyle.italic),
                ),
                currentAccountPicture: Lottie.asset(LottieConstants.instance!.DRAWER_LOTTIE),
              ),
              Padding(
                padding: context.paddingLow,
                child: const Text(
                    "Bu Uygulama M.8.1.3.6. Kazanımı için hazırlanmıştır.\n\nKareköklü ifade ile çarpıldığında sonucu doğal sayı olan çarpanları belirler."),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Karekök Uygulaması"),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                icon: const Icon(Icons.power_settings_new),
                onPressed: () {
                  exit(0);
                },
              ),
            )
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: context.width, height: context.height * 0.4, child: Lottie.asset(LottieConstants.instance!.SEVYESECME2)),
            MyButton(
                onPressed: () {
                  viewModel.navigateKolay();
                },
                title: "KOLAY",
                height: context.height * 0.07,
                width: context.width * 0.6,
                raduis: 30),
            Padding(
              padding: context.paddingLow,
              child: MyButton(
                  onPressed: () {
                    viewModel.navigateOrta();
                  },
                  title: "ORTA",
                  height: context.height * 0.07,
                  width: context.width * 0.6,
                  raduis: 30),
            ),
            Padding(
              padding: context.paddingLow,
              child: MyButton(
                  onPressed: () {
                    viewModel.navigateZor();
                  },
                  title: "ZOR",
                  height: context.height * 0.07,
                  width: context.width * 0.6,
                  raduis: 30),
            )
          ],
        ),
      ),
    );
  }
}
