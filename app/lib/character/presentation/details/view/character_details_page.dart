import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/presentation/details/character_details.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({
    required this.character,
    super.key,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharacterDetailsPageBloc>(
      create: (context) => CharacterDetailsPageBloc(
        character: character,
      ),
      child: const DetailsView(),
    );
  }
}

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterDetailsPageBloc, CharacterDetailsPageState>(
      builder: (context, state) {
        final character = state.character;

        return Hero(
          tag: character.id,
          
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text(character.name),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CachedNetworkImage(
                    imageUrl: character.image,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          character.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Status: ${character.status.status}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        const Divider(height: 1),
                        const SizedBox(height: 16),
                        Text(
                          'Origin: ${character.origin.name}',
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Last location: ${character.location.name}',
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Species: ${character.species}',
                        ),
                        if (character.type.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Type: ${character.type}',
                          ),
                        ],
                        const SizedBox(height: 8),
                        Text(
                          'Gender: ${character.gender.gender}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
