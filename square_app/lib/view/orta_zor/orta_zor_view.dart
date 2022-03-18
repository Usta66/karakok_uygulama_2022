import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:square_app/utils/navigation/enum/enum_navigate.dart';
import 'package:square_app/view/orta_zor/orta_zor_view_model.dart';

import '../../base/view/base_view.dart';
import '../../init/ortak_fonksiyonlar.dart';
import '../../model/karekok_model.dart';
import '../home/home_view_model.dart';

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
            title: viewModel.isZor ? Text("ZOR") : Text("ORTA"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                runSpacing: 20,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(color: Color(0xFFFFD900), borderRadius: BorderRadiusDirectional.circular(100)),
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                  child: TextField(
                                readOnly: true,
                                style: Theme.of(context).textTheme.headline5,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(border: InputBorder.none),
                                controller: viewModel.sureController,
                              ))

                              //color: viewModel.modelList[i].renk
                              )

                          // TextField(
                          //   style: Theme.of(context).textTheme.headline5,
                          //   textAlign: TextAlign.center,
                          //   decoration: InputDecoration(border: InputBorder.none),
                          //   controller: sureController,
                          // ),
                          ),
                      Spacer(),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(color: Color(0xFFFFD900), borderRadius: BorderRadiusDirectional.circular(100)),
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            readOnly: true,
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(border: InputBorder.none),
                            controller: viewModel.puanController,
                          ),
                        ),

                        //color: viewModel.modelList[i].renk
                      ),
                      Spacer(),
                    ],
                  ),
                  GridView.count(
                      shrinkWrap: true,
                      controller: ScrollController(keepScrollOffset: false),
                      scrollDirection: Axis.vertical,
                      // primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 4,
                      children: [
                        for (var i = 0; i < 16; i++)
                          InkResponse(onTap: () async {
                            if (viewModel.birinciSecilen == null) {
                              viewModel.birinciSecilen = i;

                              viewModel.renkDegistir(viewModel.seciliRenk, viewModel.birinciSecilen!);
                            } else if (viewModel.ikinciSecilen == null) {
                              viewModel.ikinciSecilen = i;

                              viewModel.renkDegistir(viewModel.seciliRenk, viewModel.ikinciSecilen!);
                            }

                            if (viewModel.birinciSecilen == viewModel.ikinciSecilen) {
                              viewModel.renkDegistir(viewModel.normal, viewModel.birinciSecilen!);

                              viewModel.renkDegistir(viewModel.normal, viewModel.ikinciSecilen!);

                              viewModel.birinciSecilen = null;
                              viewModel.ikinciSecilen = null;
                            } else if (viewModel.birinciSecilen != null && viewModel.ikinciSecilen != null) {
                              await Future.delayed(const Duration(seconds: 1));

                              viewModel.renkDegistir(viewModel.normal, viewModel.birinciSecilen!);

                              if (dogalSayimi(viewModel.modelList[viewModel.birinciSecilen!].b, viewModel.modelList[viewModel.ikinciSecilen!].b)) {
                                viewModel.renkDegistir(viewModel.dogru, viewModel.birinciSecilen!);

                                viewModel.renkDegistir(viewModel.dogru, viewModel.ikinciSecilen!);

                                await Future.delayed(const Duration(seconds: 1));
                                viewModel.puanArtir();
                                viewModel.oyunSuresiArtir();

                                viewModel.renkDegistir(viewModel.normal, viewModel.birinciSecilen!);

                                viewModel.renkDegistir(viewModel.normal, viewModel.ikinciSecilen!);
                                viewModel.modelList.removeAt(viewModel.birinciSecilen!);
                                viewModel.modelList.insert(viewModel.birinciSecilen!,
                                    KaraKokModel(a: Random().nextInt(5) + 1, b: viewModel.bList[Random().nextInt(viewModel.bList.length)]));

                                viewModel.modelList.removeAt(viewModel.ikinciSecilen!);

                                viewModel.modelList.insert(viewModel.ikinciSecilen!,
                                    KaraKokModel(a: Random().nextInt(5) + 1, b: viewModel.bList[Random().nextInt(viewModel.bList.length)]));

                                ;

                                viewModel.birinciSecilen = null;
                                viewModel.ikinciSecilen = null;
                              } else {
                                // viewModel.modelList[viewModel.birinciSecilen!]
                                // .renk = viewModel.yanlis;
                                viewModel.renkDegistir(viewModel.yanlis, viewModel.birinciSecilen!);

                                //viewModel.modelList[viewModel.ikinciSecilen!]
                                // .renk = viewModel.yanlis;
                                viewModel.renkDegistir(viewModel.yanlis, viewModel.ikinciSecilen!);
                                await Future.delayed(const Duration(seconds: 1));

                                viewModel.renkDegistir(viewModel.normal, viewModel.birinciSecilen!);

                                viewModel.renkDegistir(viewModel.normal, viewModel.ikinciSecilen!);
                              }

                              viewModel.birinciSecilen = null;
                              viewModel.ikinciSecilen = null;
                            }
                          }, child: Consumer<OrtaZorViewModel>(
                            builder: (_, value, __) {
                              return Container(
                                  decoration: BoxDecoration(color: viewModel.modelList[i].renk, borderRadius: BorderRadiusDirectional.circular(100)),
                                  padding: const EdgeInsets.all(8),
                                  child: Center(
                                      child: Text(
                                    "${viewModel.modelList[i].a} √${viewModel.modelList[i].b} ",
                                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
                                  ))

                                  //color: viewModel.modelList[i].renk
                                  );
                            },
                          ))
                      ]),
                  Center(
                      child: ElevatedButton(
                          onPressed: () {
                            viewModel.navigateHome();
                          },
                          child: Text("MENÜ")))
                ],
              ),
            ),
          ),
        ));
  }
}
