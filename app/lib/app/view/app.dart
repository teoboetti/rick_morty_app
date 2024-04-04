import 'package:api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/character/data/character_repository_impl.dart';
import 'package:rick_morty_app/character/domain/usecase/get_character_by_id.dart';
import 'package:rick_morty_app/character/domain/usecase/get_paginated_characters.dart';
import 'package:rick_morty_app/character/domain/usecase/search_character.dart';
import 'package:rick_morty_app/core/di/injector.dart';
import 'package:rick_morty_app/core/router/router.dart';
import 'package:rick_morty_app/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return _Injector(
      child: MaterialApp.router(
        routerConfig: getIt<AppRouter>().routerConfig,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}

class _Injector extends StatefulWidget {
  const _Injector({
    required this.child,
  });

  final Widget child;

  @override
  State<_Injector> createState() => __InjectorState();
}

class __InjectorState extends State<_Injector> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiImpl>(
          create: (_) => ApiImpl(getIt<ApiClient>()),
        ),
        RepositoryProvider<CharacterRepositoryImpl>(
          create: (context) => CharacterRepositoryImpl(
            api: context.read<ApiImpl>(),
          ),
        ),
        RepositoryProvider<GetPaginatedCharacters>(
          create: (context) => GetPaginatedCharacters(
            repository: context.read<CharacterRepositoryImpl>(),
          ),
        ),
        RepositoryProvider<GetCharacterByID>(
          create: (context) => GetCharacterByID(
            repository: context.read<CharacterRepositoryImpl>(),
          ),
        ),
        RepositoryProvider<SearchCharacter>(
          create: (context) => SearchCharacter(
            repository: context.read<CharacterRepositoryImpl>(),
          ),
        ),
      ],
      child: widget.child,
    );
  }
}
