import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/character/domain/usecase/get_paginated_characters.dart';
import 'package:rick_morty_app/character/presentation/characters/characters.dart';
import 'package:rick_morty_app/components/character_tile.dart';
import 'package:rick_morty_app/components/loading.dart';
import 'package:rick_morty_app/core/router/routes.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersPageBloc>(
      create: (context) => CharactersPageBloc(
        getPaginatedCharacters: context.read<GetPaginatedCharacters>(),
      )..add(
          const FetchPageEvent(),
        ),
      child: const CharactersView(),
    );
  }
}

class CharactersView extends StatelessWidget {
  const CharactersView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CharactersPageBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rick and Morty',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Schwifty',
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              const SearchRoute().go(context);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: state is CharactersPageInitial
          ? const Loading()
          : const CharactersContent(),
    );
  }
}

class CharactersContent extends StatefulWidget {
  const CharactersContent({super.key});

  @override
  State<CharactersContent> createState() => _CharactersContentState();
}

class _CharactersContentState extends State<CharactersContent> {
  final _scrollController = ScrollController();

  CharactersPageBloc get _pageBloc => context.read<CharactersPageBloc>();

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _pageBloc.add(const FetchPageEvent());
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CharactersPageBloc, CharactersPageState>(
        builder: (context, state) {
          switch (state) {
            case CharacterPageSuccess():
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedEnd
                    ? state.characters.length
                    : state.characters.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.characters.length) {
                    if (state.hasMoreToFetch) {
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: const Loading(),
                        ),
                      );
                    }

                    return const SizedBox();
                  }

                  final character = state.characters[index];

                  return CharacterTile(
                    character: character,
                    onTap: () {
                      DetailsRoute($extra: character).go(context);
                    },
                  );
                },
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
