import 'package:flutter/material.dart';
import "package:kartal/kartal.dart";

class MyContainerCircular extends StatelessWidget {
  const MyContainerCircular(
      {Key? key, required this.color, this.controller, this.child})
      : super(key: key);

  final Color color;
  final Widget? child;

  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: context.width * 0.25,
          height: context.width * 0.25,
          decoration: BoxDecoration(
              color: color,
              borderRadius:
                  BorderRadiusDirectional.circular(context.width * 0.25)),
          padding: context.paddingLow,
          child: Center(
              child: child ??
                  TextField(
                    readOnly: true,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(border: InputBorder.none),
                    controller: controller,
                  ))),
    );
  }
}
