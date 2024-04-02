import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:rick_morty_app/character/domain/usecase/get_paginated_characters.dart';
import 'package:rick_morty_app/character/presentation/characters/characters.dart';
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
  late final CardSwiperController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CardSwiperController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CharactersPageBloc, CharactersPageState>(
        builder: (context, state) {
          switch (state) {
            case CharacterPageSuccess():
              return Column(
                children: [
                  Flexible(
                    child: CardSwiper(
                      controller: _controller,
                      numberOfCardsDisplayed: 3,
                      allowedSwipeDirection:
                          const AllowedSwipeDirection.symmetric(
                        horizontal: true,
                      ),
                      cardsCount: state.characters.length,
                      cardBuilder: (
                        context,
                        index,
                        _,
                        __,
                      ) {
                        final character = state.characters[index];

                        return Hero(
                          tag: character.id,
                          child: GestureDetector(
                            onTap: () {
                              DetailsRoute($extra: character).go(context);
                            },
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: CachedNetworkImage(
                                      imageUrl: character.image,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return ColoredBox(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        );
                                      },
                                    ),
                                  ),
                                  ColoredBox(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            character.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            character.species,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            character.location.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: Colors.grey,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      onSwipe: (previousIndex, currentIndex, direction) {
                        currentIndex ??= previousIndex;

                        if (currentIndex == state.characters.length - 5) {
                          context.read<CharactersPageBloc>().add(
                                const FetchPageEvent(),
                              );
                        }

                        return true;
                      },
                    ),
                  ),
                ],
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
    _controller.dispose();
    super.dispose();
  }
}
