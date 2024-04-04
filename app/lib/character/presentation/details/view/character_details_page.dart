import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/presentation/details/character_details.dart';
import 'package:rick_morty_app/components/loading.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({
    required this.cid,
    this.character,
    super.key,
  });

  final int cid;

  final Character? character;

  @override
  Widget build(BuildContext context) {
    final bloc = CharacterDetailsPageBloc(
      getCharacterByID: context.read(),
    );
    if (character != null) {
      bloc.add(
        CharacterDetailsSet(character: character!),
      );
    } else {
      bloc.add(
        CharacterDetailsFetch(id: cid),
      );
    }

    return BlocProvider<CharacterDetailsPageBloc>.value(
      value: bloc,
      child: const CharacterDetailsView(),
    );
  }
}

class CharacterDetailsView extends StatelessWidget {
  const CharacterDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CharacterDetailsPageBloc>().state;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: state is CharacterDetailsInitial || state is CharacterDetailsLoading
          ? const Loading()
          : const CharacterDetailsContent(),
    );
  }
}

class CharacterDetailsContent extends StatelessWidget {
  const CharacterDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterDetailsPageBloc, CharacterDetailsPageState>(
      builder: (context, state) {
        switch (state) {
          case CharacterDetailsSuccess():
            final character = state.character;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: character.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character.name,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: character.status.color.withOpacity(0.2),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          child: Text(
                            character.status.status,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: character.status.color,
                                ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Divider(height: 1),
                        const SizedBox(height: 16),
                        Info(
                          icon: Icons.place,
                          value: character.origin.name,
                        ),
                        const SizedBox(height: 8),
                        Info(
                          icon: Icons.near_me,
                          value: character.location.name,
                        ),
                        const SizedBox(height: 8),
                        Info(
                          icon: Icons.people,
                          value: character.species,
                        ),
                        const SizedBox(height: 8),
                        Info(
                          icon: Icons.transgender,
                          value: character.gender.gender,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    required this.icon,
    required this.value,
    super.key,
  });

  final IconData icon;

  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
