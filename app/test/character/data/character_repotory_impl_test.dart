import 'package:api/api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_app/character/data/character_repository_impl.dart';
import 'package:rick_morty_app/character/domain/entity/pagination.dart';

import '../../mocks/api_mock.dart';

void main() {
  late CharacterRepositoryImpl characterRepository;
  late MockApi mockApi;

  setUp(() {
    mockApi = MockApi();
    characterRepository = CharacterRepositoryImpl(
      api: mockApi,
    );
  });

  test(
    'CharacterRepositoryImpl',
    () async {
      final pagination = PaginationDto(
        info: const InfoDto(count: 20, pages: 1),
        results: List.generate(
          20,
          (index) => CharacterDto(
            id: index,
            name: 'name $index',
            status: 'Alive',
            species: 'species',
            type: 'type',
            gender: 'Female',
            origin: const LocationDto(name: 'name'),
            location: const LocationDto(name: 'name'),
            image: 'image',
            episode: [],
            url: 'url',
            created: DateTime.now(),
          ),
        ),
      );

      when(
        () => mockApi.getPaginatedCharacters(),
      ).thenAnswer(
        (_) async => pagination,
      );

      final result = await characterRepository.getPaginatedCharacters();

      verify(() => mockApi.getPaginatedCharacters()).called(1);
      expect(result, isA<Pagination>());
    },
  );
}
