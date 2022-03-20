import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:square_app/base/view/base_view.dart';

import '../../utils/navigation/enum/enum_navigate.dart';
import '../../utils/navigation/navigation_services.dart';
import 'onboard_model.dart';
import 'onboard_view_model.dart';
import 'package:kartal/kartal.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({Key? key, required this.viewModel}) : super(key: key);

  final OnboardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<OnboardViewModel>(
        viewModel: viewModel,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsetsDirectional.all(0.8),
            child: Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                    flex: 5,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        viewModel.changeCurrentIndex(value);
                      },
                      itemCount: viewModel.onboardItems.length,
                      itemBuilder: (context, index) => builColumnBody(
                          context, viewModel.onboardItems[index]),
                    )),
                Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: viewModel.onboardItems.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: context.paddingLow,
                                    child: Selector<OnboardViewModel, int>(
                                      selector: (p0, p1) => p1.curruntIndex,
                                      builder: (_, value, __) {
                                        return CircleAvatar(
                                          backgroundColor: Colors.purple
                                              .withOpacity(
                                                  value == index ? 1 : 0.2),
                                          radius: value == index
                                              ? context.width * 0.015
                                              : context.width * 0.01,
                                        );
                                      },
                                    ));
                              },
                            )),
                        const Spacer(),
                        FloatingActionButton(
                            backgroundColor: Colors.purpleAccent,
                            child: const Icon(Icons.keyboard_arrow_right_sharp),
                            onPressed: () {
                               NavigationServices.instance!.navigateToReset(EnumRoute.HOME);
                            })
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}

Column builColumnBody(BuildContext context, OnboardModel onboardItem) {
  return Column(
    children: [
      Expanded(flex: 5, child: buildSvgPicture(onboardItem.imagePath)),
      buildColumnDescription(context, onboardItem)
    ],
  );
}

Column buildColumnDescription(BuildContext context, OnboardModel onboardItem) {
  return Column(
    children: [
      Text(onboardItem.title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
      Padding(
        padding: context.horizontalPaddingHigh,
        child: Text(
          onboardItem.description,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black45),
        ),
      )
    ],
  );
}

SvgPicture buildSvgPicture(String imagePath) {
  return SvgPicture.asset(imagePath);
}
