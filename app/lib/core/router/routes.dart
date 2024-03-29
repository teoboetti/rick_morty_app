// ignore_for_file: no_default_cases

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/counter/counter.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return const CupertinoPage(
          child: CounterPage(),
        );

      case TargetPlatform.android:
        return const MaterialPage(
          child: CounterPage(),
        );

      default:
        throw Exception('$defaultTargetPlatform not supported');
    }
  }
}
