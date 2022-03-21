import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScaleRoute<T extends ChangeNotifier> extends PageRouteBuilder {
  T viewModel;
  final Widget page;
  ScaleRoute(this.page, this.viewModel)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              ChangeNotifierProvider(
                  create: (context) => viewModel, child: page),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}