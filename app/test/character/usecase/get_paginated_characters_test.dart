import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_app/character/domain/domain.dart';
import 'package:rick_morty_app/character/domain/repository/i_character_repository.dart';

class MockCharacterRepository extends Mock implements ICharacterRepository {}

void main() {
  late MockCharacterRepository mockRepository;
  late GetPaginatedCharacters usecase;

  setUp(() {
    mockRepository = MockCharacterRepository();
    usecase = GetPaginatedCharacters(repository: mockRepository);
  });

  test(
    'GetPaginatedCharacters',
    () async {
      final pagination = Pagination(
        info: Info(count: 20, pages: 1),
        results: List.generate(
          20,
          (index) => Character(
            id: index,
            name: 'name $index',
            status: CharacterStatus.alive,
            species: 'species',
            type: 'type',
            gender: CharacterGender.female,
            origin: Location(name: 'name'),
            location: Location(name: 'name'),
            image: 'image',
            episode: [],
            url: 'url',
            created: DateTime.now(),
          ),
        ),
      );

      when(
        () => mockRepository.getPaginatedCharacters(),
      ).thenAnswer(
        (_) async => pagination,
      );

      final result = await usecase.call();

      expect(result, pagination);
      verify(() => mockRepository.getPaginatedCharacters()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
