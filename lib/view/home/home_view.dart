// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:square_app/components/locale_text.dart';
import 'package:square_app/components/my_button.dart';
import 'package:square_app/device/constants/app_constants.dart';
import 'package:square_app/init/cache/locale_maneger.dart';
import 'package:square_app/init/locale_keys.g.dart';
import 'package:square_app/view/home/home_view_model.dart';
import 'package:kartal/kartal.dart';
import '../../base/view/base_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.viewModel}) : super(key: key);
  final HomeViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    viewModel.localeBelirle(context);

    return BaseView(
      viewModel: viewModel,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                accountName: LocaleText(
                  text: LocaleKeys.home_uygulamaAdi,
                  style: Theme.of(context).textTheme.headline5,
                ),
                accountEmail: LocaleText(
                  text: LocaleKeys.home_ogretmenAdi,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                currentAccountPicture: Lottie.asset(LottieConstants.instance!.DRAWER_LOTTIE),
              ),
              Padding(
                padding: context.paddingLow,
                child: LocaleText(text: LocaleKeys.home_hakkinda),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  viewModel.navigateOnboar();
                },
                child: LocaleText(text: LocaleKeys.home_nasilOynanir),
              ),
              const Divider(),
              Padding(
                padding: context.paddingLow,
                child: Row(
                  children: [
                    Text("Dil", style: Theme.of(context).textTheme.bodyText1),
                    Switch(
                        value: viewModel.isLangEn,
                        onChanged: (select) {
                          viewModel.isLangEn = select;

                          viewModel.changeLang(context);
                        }),
                    Text("İngilizce", style: Theme.of(context).textTheme.bodyText1)
                  ],
                ),
              ),
              Divider()
            ],
          ),
        ),
        appBar: AppBar(
          title: LocaleText(text: LocaleKeys.home_uygulamaAdi),
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
                  text: LocaleKeys.home_kolay,
                ),
              ),
              Padding(
                padding: context.paddingLow,
                child: MyButton(
                  onPressed: () {
                    viewModel.navigateOrta();
                  },
                  text: LocaleKeys.home_orta,
                ),
              ),
              Padding(
                padding: context.paddingLow,
                child: MyButton(
                  onPressed: () {
                    viewModel.navigateZor();
                  },
                  text: LocaleKeys.home_zor,
                ),
              ),
              TextButton(
                  onPressed: () {
                    LocaleManeger.instance.clear();
                  },
                  child: Text("Clear Sheard"))
            ],
          ),
        ),
      ),
    );
  }
}
