import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/character/domain/usecase/search_character.dart';
import 'package:rick_morty_app/character/presentation/search/search.dart';
import 'package:rick_morty_app/components/character_tile.dart';
import 'package:rick_morty_app/components/loading.dart';
import 'package:rick_morty_app/components/search_textfield.dart';
import 'package:rick_morty_app/core/router/routes.dart';
import 'package:rick_morty_app/l10n/l10n.dart';

class CharacterSearchPage extends StatelessWidget {
  const CharacterSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharacterSearchPageBloc>(
      create: (context) => CharacterSearchPageBloc(
        searchCharacter: context.read<SearchCharacter>(),
      ),
      child: const CharacterSearchView(),
    );
  }
}

class CharacterSearchView extends StatelessWidget {
  const CharacterSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: SearchTextfield(
                onChanged: (value) {
                  if (value.length > 3) {
                    context.read<CharacterSearchPageBloc>().add(
                          CharacterSearchEvent(name: value),
                        );
                  } else if (value.isEmpty) {
                    context.read<CharacterSearchPageBloc>().add(
                          CharacterClearSearchEvent(),
                        );
                  }
                },
              ),
            ),
            const Expanded(
              child: CharacterSearchResults(),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterSearchResults extends StatefulWidget {
  const CharacterSearchResults({super.key});

  @override
  State<CharacterSearchResults> createState() => _CharacterSearchResultsState();
}

class _CharacterSearchResultsState extends State<CharacterSearchResults> {
  final _scrollController = ScrollController();

  CharacterSearchPageBloc get _pageBloc =>
      context.read<CharacterSearchPageBloc>();

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _pageBloc.add(const CharacterSearchNextPage());
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterSearchPageBloc, CharacterSearchPageState>(
      builder: (context, state) {
        switch (state) {
          case CharacterSearchPageInitial():
            return Center(
              child: Text(context.l10n.characterSearchPageInitial),
            );
          case CharacterSearchLoading():
            return const Loading();
          case CharacterSearchNotFound():
            return Center(
              child: Text(context.l10n.characterSearchPageNotFound),
            );
          case CharacterSearchSuccess():
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
                    DetailsRoute($extra: character).push<void>(context);
                  },
                );
              },
            );
        }
      },
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
