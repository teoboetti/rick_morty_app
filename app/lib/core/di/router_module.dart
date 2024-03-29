import 'package:injectable/injectable.dart';
import 'package:rick_morty_app/core/router/router.dart';

@module
abstract class RouterModule {
  @singleton
  AppRouter get router => AppRouter();
}
