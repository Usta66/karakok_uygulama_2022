import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:square_app/base/view/base_view.dart';
import 'package:square_app/view/kolay/kolay_view_model.dart';

import '../../init/ortak_fonksiyonlar.dart';

class KolayView extends StatelessWidget {
  const KolayView({Key? key, required this.viewModel}) : super(key: key);

  final KolayViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel.geriSayimSayaci(context);
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
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(color: viewModel.normal, borderRadius: BorderRadiusDirectional.circular(100)),
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: TextField(
                            readOnly: true,
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(border: InputBorder.none),
                            controller: viewModel.kareKokController),
                      ),
                    ),
                  ),
                  GridView.count(
                      shrinkWrap: true,
                      controller: ScrollController(keepScrollOffset: false),
                      scrollDirection: Axis.vertical,
                      // primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 3,
                      children: [
                        for (var i = 0; i < 6; i++)
                          InkResponse(onTap: () async {
                            if (viewModel.birinciSecilen == null) {
                              viewModel.birinciSecilen = i;

                              viewModel.renkDegistir(viewModel.seciliRenk, viewModel.birinciSecilen!);
                            }

                            {
                              await Future.delayed(const Duration(seconds: 1));

                              viewModel.renkDegistir(viewModel.normal, viewModel.birinciSecilen!);

                              // viewModel.modelList[viewModel.ikinciSecilen].renk =
                              //     normal;

                              if (dogalSayimi(viewModel.modelList[viewModel.birinciSecilen!].b, viewModel.b)) {
                                viewModel.renkDegistir(viewModel.dogru, viewModel.birinciSecilen!);

                                await Future.delayed(const Duration(seconds: 1));

                                viewModel.puanArtir();

                                viewModel.oyunSuresiArtir();

                                viewModel.karekokDegistir();

                                viewModel.renkDegistir(viewModel.normal, viewModel.birinciSecilen!);

                                viewModel.birinciSecilen = null;
                              } else {
                                viewModel.renkDegistir(viewModel.yanlis, viewModel.birinciSecilen!);

                                await Future.delayed(const Duration(seconds: 1));

                                viewModel.renkDegistir(viewModel.normal, viewModel.birinciSecilen!);
                              }

                              viewModel.birinciSecilen = null;
                            }
                          }, child: Consumer<KolayViewModel>(
                            builder: (context, value, child) {
                              return Container(
                                  decoration: BoxDecoration(color: viewModel.modelList[i].renk, borderRadius: BorderRadiusDirectional.circular(100)),
                                  padding: const EdgeInsets.all(8),
                                  child: Center(
                                      child: Text(
                                    "${viewModel.modelList[i].a} √${viewModel.modelList[i].b} ",
                                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
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
