import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/character/character.dart';
import 'package:rick_morty_app/character/presentation/characters/characters.dart';
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
        title: const Text('Rick and Morty'),
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
          ? const Center(
              child: CircularProgressIndicator(),
            )
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
      minimum: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
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
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  }

                  final character = state.characters[index];

                  return ListTile(
                    onTap: () {
                      DetailsRoute($extra: character).go(context);
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        character.image,
                      ),
                    ),
                    title: Text(character.name),
                    subtitle: Text(character.species),
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
