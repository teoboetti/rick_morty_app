import 'package:api/src/models/location_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character_dto.g.dart';

/// [CharacterDto] status enum
enum CharacterStatus {
  /// alive
  @JsonValue('Alive')
  alive,

  /// dead
  @JsonValue('Dead')
  dead,

  /// unknown
  @JsonValue('unknown')
  unknown,
}

/// [CharacterDto] gender enum
enum CharacterGender {
  /// female
  @JsonValue('Female')
  female,

  /// male
  @JsonValue('Male')
  male,

  /// genderless
  @JsonValue('Genderless')
  genderless,

  /// unknown
  @JsonValue('unknown')
  unknown,
}

/// {@template character}
/// Character model
/// {@endtemplate}
@JsonSerializable()
class CharacterDto {
  /// {@macro character}
  CharacterDto({
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

  /// {@macro character} from json
  factory CharacterDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterDtoFromJson(json);

  /// The id of the character.
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
  final LocationDto origin;

  /// Name and link to the character's last known location endpoint.
  final LocationDto location;

  /// Link to the character's image.
  final String image;

  /// List of episodes in which this character appeared.
  final List<String> episode;

  /// Link to the character's own URL endpoint.
  final String url;

  /// Time at which the character was created in the database.
  final DateTime created;

  /// toJson
  Map<String, dynamic> toJson() => _$CharacterDtoToJson(this);
}
