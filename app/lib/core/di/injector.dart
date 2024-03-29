import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_morty_app/core/di/injector.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void initDependencies() => getIt.init();
