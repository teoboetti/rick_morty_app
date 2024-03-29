import 'package:api/src/models/character_dto.dart';
import 'package:api/src/models/location_dto.dart';
import 'package:test/test.dart';

void main() {
  test(
    'CharacterDto',
    () {
      const id = 1;
      const name = 'Rick Sanchez';
      const status = CharacterStatus.alive;
      const species = 'Human';
      const type = 'Superhuman';
      const gender = CharacterGender.male;
      final origin = LocationDto(
        name: 'Earth',
      );
      final location = LocationDto(
        name: 'Earth',
      );
      const image = 'https://rickandmortyapi.com/api/character/avatar/1.jpeg';
      final episode = [
        'https://rickandmortyapi.com/api/episode/1',
        'https://rickandmortyapi.com/api/episode/2'
      ];
      const url = 'https://rickandmortyapi.com/api/character/1';
      final created = DateTime.now();

      final character = CharacterDto(
        id: id,
        name: name,
        status: status,
        species: species,
        type: type,
        gender: gender,
        origin: origin,
        location: location,
        image: image,
        episode: episode,
        url: url,
        created: created,
      );

      expect(character.id, id);
      expect(character.name, name);
      expect(character.status, status);
      expect(character.species, species);
      expect(character.type, type);
      expect(character.gender, gender);
      expect(character.origin, origin);
      expect(character.location, location);
      expect(character.image, image);
      expect(character.episode, episode);
      expect(character.url, url);
      expect(character.created, created);
    },
  );
}
