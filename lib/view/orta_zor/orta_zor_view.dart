import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/locale_text.dart';
import '../../init/locale_keys.g.dart';
import 'orta_zor_view_model.dart';
import '../../base/view/base_view.dart';
import '../../components/my_button.dart';
import '../../components/my_container_circular.dart';
import '../../device/theme/myColors.dart';
import 'package:kartal/kartal.dart';

class OrtaZorView extends StatelessWidget {
  const OrtaZorView({Key? key, required this.viewModel}) : super(key: key);

  final OrtaZorViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
          key: viewModel.scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            // ignore: prefer_const_constructors
            title: viewModel.isZor ? LocaleText(text: LocaleKeys.home_orta) : LocaleText(text: LocaleKeys.home_zor),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
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
        crossAxisCount: 4,
        children: [
          for (var i = 0; i < 16; i++)
            InkResponse(onTap: () async {
              if (viewModel.birinciSecilen == null) {
                viewModel.birinciSecilen = i;

                viewModel.renkDegistir(MyColors.instance!.seciliRenk, viewModel.birinciSecilen!);
              } else if (viewModel.ikinciSecilen == null) {
                viewModel.ikinciSecilen = i;

                viewModel.renkDegistir(MyColors.instance!.seciliRenk, viewModel.ikinciSecilen!);
              }

              if (viewModel.birinciSecilen == viewModel.ikinciSecilen) {
                viewModel.renkDegistir(MyColors.instance!.normal, viewModel.birinciSecilen!);

                viewModel.renkDegistir(MyColors.instance!.normal, viewModel.ikinciSecilen!);

                viewModel.birinciSecilen = null;
                viewModel.ikinciSecilen = null;
              } else if (viewModel.birinciSecilen != null && viewModel.ikinciSecilen != null) {
                await Future.delayed(const Duration(seconds: 1));

                viewModel.renkDegistir(MyColors.instance!.normal, viewModel.birinciSecilen!);

                if (viewModel.dogalSayimi()) {
                  viewModel.renkDegistir(MyColors.instance!.dogru, viewModel.birinciSecilen!);

                  viewModel.renkDegistir(MyColors.instance!.dogru, viewModel.ikinciSecilen!);

                  await Future.delayed(const Duration(seconds: 1));
                  viewModel.puanArtir();
                  viewModel.oyunSuresiArtir();

                  viewModel.renkDegistir(MyColors.instance!.normal, viewModel.birinciSecilen!);

                  viewModel.renkDegistir(MyColors.instance!.normal, viewModel.ikinciSecilen!);

                  viewModel.yeniSayiEkle();

                  viewModel.birinciSecilen = null;
                  viewModel.ikinciSecilen = null;
                } else {
                  viewModel.renkDegistir(MyColors.instance!.yanlis, viewModel.birinciSecilen!);

                  viewModel.renkDegistir(MyColors.instance!.yanlis, viewModel.ikinciSecilen!);
                  await Future.delayed(const Duration(seconds: 1));

                  viewModel.renkDegistir(MyColors.instance!.normal, viewModel.birinciSecilen!);

                  viewModel.renkDegistir(MyColors.instance!.normal, viewModel.ikinciSecilen!);
                }

                viewModel.birinciSecilen = null;
                viewModel.ikinciSecilen = null;
              }
            }, child: Consumer<OrtaZorViewModel>(
              builder: (_, value, __) {
                return MyContainerCircular(
                  color: viewModel.modelList[i].renk,
                  child: Center(
                      child: Text(
                    "${viewModel.modelList[i].a} √${viewModel.modelList[i].b} ",
                    style: TextStyle(fontSize: context.width * 0.04),
                  )),
                );
              },
            ))
        ]);
  }
}
