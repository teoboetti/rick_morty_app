// ignore_for_file: no_default_cases

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/character/character.dart';
import 'package:rick_morty_app/character/presentation/characters/characters.dart';
import 'package:rick_morty_app/character/presentation/details/character_details.dart';
import 'package:rick_morty_app/character/presentation/search/search.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<DetailsRoute>(
      path: 'details',
    ),
    TypedGoRoute<SearchRoute>(
      path: 'search',
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return const CupertinoPage(
          child: CharactersPage(),
        );

      case TargetPlatform.android:
        return const MaterialPage(
          child: CharactersPage(),
        );

      default:
        throw Exception('$defaultTargetPlatform not supported');
    }
  }
}

class DetailsRoute extends GoRouteData {
  const DetailsRoute({
    required this.$extra,
  });

  final Character $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return CupertinoPage(
          child: CharacterDetailsPage(
            character: $extra,
          ),
        );

      case TargetPlatform.android:
        return MaterialPage(
          child: CharacterDetailsPage(
            character: $extra,
          ),
        );

      default:
        throw Exception('$defaultTargetPlatform not supported');
    }
  }
}

class SearchRoute extends GoRouteData {
  const SearchRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return const CupertinoPage(
          child: CharacterSearchPage(),
        );

      case TargetPlatform.android:
        return const MaterialPage(
          child: CharacterSearchPage(),
        );

      default:
        throw Exception('$defaultTargetPlatform not supported');
    }
  }
}
