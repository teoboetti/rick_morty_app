import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';

class CharacterTile extends StatelessWidget {
  const CharacterTile({
    required this.character,
    this.onTap,
    super.key,
  });

  final Character character;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(character.id),
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          character.image,
        ),
      ),
      title: Text(character.name),
      subtitle: Text(character.species),
    );
  }
}
