// ignore_for_file: no_default_cases

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/presentation/characters/characters.dart';
import 'package:rick_morty_app/character/presentation/details/view/character_details_page.dart';
import 'package:rick_morty_app/character/presentation/search/view/character_search_page.dart';
import 'package:rick_morty_app/core/router/components/scaffold_with_navbar.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

@TypedStatefulShellRoute<AppShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(
          path: '/',
          routes: [
            TypedGoRoute<DetailsRoute>(
              path: 'details',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<SearchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SearchRoute>(
          path: '/search',
        ),
      ],
    ),
  ],
)
class AppShellRoute extends StatefulShellRouteData {
  const AppShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return navigationShell;
  }

  static const String $restorationScopeId = 'shell-id';

  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) {
    return ScaffoldWithNavBar(
      navigationShell: navigationShell,
      children: children,
    );
  }
}

class HomeData extends StatefulShellBranchData {
  const HomeData();

  static const String $restorationScopeId = 'home-id';
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return getPlatformPage(
      const CharactersPage(),
    );
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
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: CharacterDetailsPage(
        character: $extra,
      ),
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}

class SearchData extends StatefulShellBranchData {
  const SearchData();

  static const String $restorationScopeId = 'search-id';
}

class SearchRoute extends GoRouteData {
  const SearchRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return getPlatformPage(
      const CharacterSearchPage(),
    );
  }
}

extension GoRouteDataX on GoRouteData {
  Page<T> getPlatformPage<T>(Widget child) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return CupertinoPage(child: child);
      case TargetPlatform.android:
        return MaterialPage(child: child);

      default:
        throw ArgumentError('$defaultTargetPlatform not supported');
    }
  }
}
