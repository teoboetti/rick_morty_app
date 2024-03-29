import 'package:api/api.dart';
import 'package:rick_morty_app/character/domain/entity/location.dart';

class Character {
  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  final int id;

  /// The name of the character.
  final String name;

  /// The status of the character ('Alive', 'Dead' or 'unknown').
  final CharacterStatus status;

  /// The species of the character.
  final String species;

  /// The type or subspecies of the character.
  final String type;

  /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
  final CharacterGender gender;

  /// Name and link to the character's origin location.
  final Location origin;

  /// Name and link to the character's last known location endpoint.
  final Location location;

  /// Link to the character's image.
  final String image;

  /// List of episodes in which this character appeared.
  final List<String> episode;

  /// Link to the character's own URL endpoint.
  final String url;

  /// Time at which the character was created in the database.
  final DateTime created;
}

extension CharacterDtoX on CharacterDto {
  Character toDomain() {
    return Character(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      origin: origin.toDomain(),
      location: location.toDomain(),
      image: image,
      episode: episode,
      url: url,
      created: created,
    );
  }
}
