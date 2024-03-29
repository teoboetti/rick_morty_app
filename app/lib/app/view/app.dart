import 'package:flutter/material.dart';
import 'package:rick_morty_app/core/di/injector.dart';
import 'package:rick_morty_app/core/router/router.dart';
import 'package:rick_morty_app/l10n/l10n.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: getIt<AppRouter>().routerConfig,
      theme: ThemeData(
        fontFamily: 'Schwifty',
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
