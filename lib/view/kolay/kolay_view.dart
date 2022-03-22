import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:square_app/base/view/base_view.dart';
import 'package:square_app/components/my_button.dart';
import 'package:square_app/components/my_container_circular.dart';
import 'package:square_app/init/locale_keys.g.dart';
import 'package:square_app/view/kolay/kolay_view_model.dart';
import "package:kartal/kartal.dart";
import '../../init/ortak_fonksiyonlar.dart';

class KolayView extends StatelessWidget {
  const KolayView({Key? key, required this.viewModel}) : super(key: key);

  final KolayViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
          key: viewModel.scaffoldKey,
          appBar: AppBar(
            title: const Text("KOLAY"),
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
                        color: viewModel.zamanVeSkor,
                        controller: viewModel.sureController,
                      )),
                      Expanded(child: MyContainerCircular(color: viewModel.zamanVeSkor, controller: viewModel.puanController)),
                    ],
                  ),
                  MyContainerCircular(
                    color: viewModel.normal,
                    controller: viewModel.kareKokController,
                  ),
                  GridView.count(
                      shrinkWrap: true,
                      controller: ScrollController(keepScrollOffset: false),
                      scrollDirection: Axis.vertical,
                      // primary: false,
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
                                viewModel.seciliRenk,
                              );
                            }

                            {
                              await Future.delayed(const Duration(seconds: 1));

                              viewModel.renkDegistir(viewModel.normal);

                              if (dogalSayimi(viewModel.modelList[viewModel.birinciSecilen!].b, viewModel.b)) {
                                viewModel.renkDegistir(viewModel.dogru);

                                await Future.delayed(const Duration(seconds: 1));

                                viewModel.puanArtir();

                                viewModel.oyunSuresiArtir();

                                viewModel.karekokDegistir();

                                viewModel.renkDegistir(viewModel.normal);

                                viewModel.birinciSecilen = null;
                              } else {
                                viewModel.renkDegistir(viewModel.yanlis);

                                await Future.delayed(const Duration(seconds: 1));

                                viewModel.renkDegistir(viewModel.normal);
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
                      ]),
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
}
