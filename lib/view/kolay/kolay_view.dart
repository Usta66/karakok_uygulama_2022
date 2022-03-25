// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:square_app/base/view/base_view.dart';
import 'package:square_app/components/my_button.dart';
import 'package:square_app/components/my_container_circular.dart';
import 'package:square_app/device/theme/myColors.dart';
import 'package:square_app/init/locale_keys.g.dart';
import 'package:square_app/view/kolay/kolay_view_model.dart';
import "package:kartal/kartal.dart";
import '../../components/locale_text.dart';

class KolayView extends StatelessWidget {
  const KolayView({Key? key, required this.viewModel}) : super(key: key);

  final KolayViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    Theme.of(context).primaryColor;
    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
          key: viewModel.scaffoldKey,
          appBar: AppBar(
            title: LocaleText(text: LocaleKeys.home_kolay),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: context.paddingNormal,
              child: Wrap(
                runSpacing: context.normalValue,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: MyContainerCircular(
                        color: MyColors.instance!.zamanVeSkor,
                        controller: viewModel.sureController,
                      )),
                      Expanded(child: MyContainerCircular(color: MyColors.instance!.zamanVeSkor, controller: viewModel.puanController)),
                    ],
                  ),
                  MyContainerCircular(
                    color: MyColors.instance!.normal,
                    controller: viewModel.kareKokController,
                  ),
                  buildGridView(context),
                  Center(
                      child: MyButton(
                          onPressed: () {
                            viewModel.navigateHome();
                          },
                          text: LocaleKeys.home_menu))
                ],
              ),
            ),
          ),
        ));
  }

  GridView buildGridView(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        controller: ScrollController(keepScrollOffset: false),
        scrollDirection: Axis.vertical,
        padding: context.paddingNormal,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: [
          for (var i = 0; i < 6; i++)
            InkResponse(onTap: () async {
              if (viewModel.birinciSecilen == null) {
                viewModel.birinciSecilen = i;

                viewModel.renkDegistir(
                  MyColors.instance!.seciliRenk,
                );
              }

              {
                await Future.delayed(const Duration(seconds: 1));

                viewModel.renkDegistir(MyColors.instance!.normal);

                if (viewModel.dogalSayimi()) {
                  viewModel.renkDegistir(MyColors.instance!.dogru);

                  await Future.delayed(const Duration(seconds: 1));

                  viewModel.puanArtir();

                  viewModel.oyunSuresiArtir();

                  viewModel.karekokDegistir();

                  viewModel.renkDegistir(MyColors.instance!.normal);

                  viewModel.birinciSecilen = null;
                } else {
                  viewModel.renkDegistir(MyColors.instance!.yanlis);

                  await Future.delayed(const Duration(seconds: 1));

                  viewModel.renkDegistir(MyColors.instance!.normal);
                }

                viewModel.birinciSecilen = null;
              }
            }, child: Consumer<KolayViewModel>(
              builder: (context, value, child) {
                return MyContainerCircular(
                  color: viewModel.modelList[i].renk,
                  child: Center(
                      child: Text(
                    "${viewModel.modelList[i].a} √${viewModel.modelList[i].b} ",
                    style: TextStyle(fontSize: context.width * 0.06),
                  )),
                );
              },
            ))
        ]);
  }
}
