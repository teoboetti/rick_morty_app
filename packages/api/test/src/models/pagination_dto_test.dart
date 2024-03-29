import 'package:api/src/models/character_dto.dart';
import 'package:api/src/models/info_dto.dart';
import 'package:api/src/models/location_dto.dart';
import 'package:api/src/models/pagination_dto.dart';
import 'package:test/test.dart';

void main() {
  test(
    'PaginationDto',
    () {
      const info = InfoDto(
        count: 10,
        pages: 1,
      );
      final results = [
        CharacterDto(
          id: 1,
          name: 'John',
          status: CharacterStatus.alive,
          species: 'Human',
          type: '',
          gender: CharacterGender.male,
          origin: LocationDto(
            name: 'Earth',
          ),
          location: LocationDto(
            name: 'Earth',
          ),
          image: '',
          episode: [],
          url: '',
          created: DateTime.now(),
        ),
      ];

      final paginationDto = PaginationDto(
        info: info,
        results: results,
      );

      expect(paginationDto.info, equals(info));
      expect(paginationDto.results, equals(results));
    },
  );
}
