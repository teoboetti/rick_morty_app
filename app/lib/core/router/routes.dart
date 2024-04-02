// ignore_for_file: no_default_cases

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/presentation/characters/view/characters_page.dart';
import 'package:rick_morty_app/character/presentation/details/view/character_details_page.dart';
import 'package:rick_morty_app/character/presentation/search/view/character_search_page.dart';
import 'package:rick_morty_app/core/router/components/app_shell_route.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

@TypedShellRoute<AppShellRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(
      path: '/',
      routes: [
        TypedGoRoute<DetailsRoute>(
          path: 'details',
        ),
      ],
    ),
    TypedGoRoute<SearchRoute>(
      path: '/search',
    ),
  ],
)
class AppShellRoute extends ShellRouteData {
  const AppShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    return AppShellRoutePage(
      child: navigator,
    );
  }
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return getPlatformPage(const CharactersPage());
  }
}

class SearchRoute extends GoRouteData {
  const SearchRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return getPlatformPage(const CharacterSearchPage());
  }
}

class DetailsRoute extends GoRouteData {
  const DetailsRoute({
    required this.$extra,
  });

  final Character $extra;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return getPlatformPage(
      CharacterDetailsPage(
        character: $extra,
      ),
    );
  }
}

extension GoRouteDataX on GoRouteData {
  Page<T> getPlatformPage<T>(Widget child) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return CupertinoPage(
          child: child,
        );

      case TargetPlatform.android:
        return MaterialPage(
          child: child,
        );

      default:
        throw Exception('$defaultTargetPlatform not supported');
    }
  }
}
