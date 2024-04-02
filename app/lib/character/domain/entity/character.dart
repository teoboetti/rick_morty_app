import 'package:api/api.dart';
import 'package:rick_morty_app/character/domain/entity/gender.dart';
import 'package:rick_morty_app/character/domain/entity/location.dart';
import 'package:rick_morty_app/character/domain/entity/status.dart';

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

  Map<String, dynamic>? encode() {
    return {
      'id': id,
      'name': name,
      'status': status.toString(),
      'species': species,
      'type': type,
      'gender': gender.toString(),
      'image': image,
      'episode': episode,
      'url': url,
      'created': created.toIso8601String(),
    };
  }

  Character? decode(Map<String, dynamic>? data) {
    if (data == null) return null;
    return Character(
      id: data['id'] as int,
      name: data['name'] as String,
      status: CharacterStatus.parse(data['status'] as String),
      species: data['species'] as String,
      type: data['type'] as String,
      gender: CharacterGender.parse(data['gender'] as String),
      origin: Location(name: ''),
      location: Location(name: ''),
      image: data['image'] as String,
      episode: List<String>.from(data['episode'] as List),
      url: data['url'] as String,
      created: DateTime.parse(data['created'] as String),
    );
  }
}

extension CharacterDtoX on CharacterDto {
  Character toDomain() {
    return Character(
      id: id,
      name: name,
      status: CharacterStatus.parse(status),
      species: species,
      type: type,
      gender: CharacterGender.parse(gender),
      origin: origin.toDomain(),
      location: location.toDomain(),
      image: image,
      episode: episode,
      url: url,
      created: created,
    );
  }
}
