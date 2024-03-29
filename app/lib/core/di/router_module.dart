import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty_app/core/router/routes.dart';

@module
abstract class RouterModule {
  @singleton
  GoRouter get router => GoRouter(
        debugLogDiagnostics: kDebugMode,
        initialLocation: const HomeRoute().location,
        routes: $appRoutes,
      );
}
