import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:square_app/components/locale_text.dart';
import 'package:square_app/components/my_button.dart';
import 'package:square_app/device/constants/app_constants.dart';
import 'package:square_app/init/locale_keys.g.dart';
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
                decoration: const BoxDecoration(color: Colors.white),
                accountName: const LocaleText(
                  text: LocaleKeys.home_uygulamaAdi,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                accountEmail: const LocaleText(
                  text: LocaleKeys.home_ogretmenAdi,
                  style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 15, fontStyle: FontStyle.italic),
                ),
                currentAccountPicture: Lottie.asset(LottieConstants.instance!.DRAWER_LOTTIE),
              ),
              Padding(
                padding: context.paddingLow,
                child: const LocaleText(text: LocaleKeys.home_hakkinda),
              ),
              const Divider(),
              TextButton(
                  onPressed: () {
                    viewModel.navigateOnboar();
                  },
                  child: Consumer<HomeViewModel>(
                    // ignore: prefer_const_constructors
                    builder: (context, value, child) => LocaleText(text: LocaleKeys.home_nasilOynanir),
                  )),
              Consumer<HomeViewModel>(
                builder: (context, value, child) {
                  return Switch(
                      value: value.isLangEn,
                      onChanged: (select) {
                        value.isLangEn = select;
                        viewModel.changeLang(context);
                      });
                },
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: context.width, height: context.height * 0.4, child: Lottie.asset(LottieConstants.instance!.SEVYESECME2)),
              Padding(
                padding: context.paddingLow,
                child: MyButton(
                  onPressed: () {
                    viewModel.navigateKolay();
                  },
                  title: "KOLAY",
                ),
              ),
              Padding(
                padding: context.paddingLow,
                child: MyButton(
                  onPressed: () {
                    viewModel.navigateOrta();
                  },
                  title: "ORTA",
                ),
              ),
              Padding(
                padding: context.paddingLow,
                child: MyButton(
                  onPressed: () {
                    viewModel.navigateZor();
                  },
                  title: "ZOR",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
