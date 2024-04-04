import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/domain/entity/gender.dart';
import 'package:rick_morty_app/character/domain/entity/location.dart';
import 'package:rick_morty_app/character/domain/entity/status.dart';
import 'package:rick_morty_app/character/domain/usecase/get_character_by_id.dart';
import 'package:rick_morty_app/character/presentation/details/bloc/character_details_page_bloc.dart';

import '../../../../mocks/usecases.dart';

void main() {
  group(
    'CharacterDetailsPageBloc',
    () {
      late GetCharacterByID mockGetCharacterByID;
      late CharacterDetailsPageBloc bloc;
      late Character character;

      setUp(
        () {
          mockGetCharacterByID = MockGetCharacterByID();
          bloc = CharacterDetailsPageBloc(
            getCharacterByID: mockGetCharacterByID,
          );
          character = Character(
            id: 1,
            name: 'name',
            status: CharacterStatus.alive,
            species: 'species',
            type: 'type',
            gender: CharacterGender.male,
            origin: Location(name: 'name'),
            location: Location(name: 'name'),
            image: 'image',
            episode: [],
            url: 'url',
            created: DateTime.now(),
          );
        },
      );

      test('initial state is CharacterDetailsInitial', () {
        expect(bloc.state, equals(const CharacterDetailsInitial()));
      });

      blocTest<CharacterDetailsPageBloc, CharacterDetailsPageState>(
        'emits [CharacterDetailsLoading, CharacterDetailsSuccess] '
        'when CharacterDetailsFetch is added',
        build: () {
          when(
            () => mockGetCharacterByID.call(
              id: any<int>(named: 'id'),
            ),
          ).thenAnswer(
            (_) async => character,
          );

          return bloc;
        },
        act: (bloc) => bloc.add(
          CharacterDetailsFetch(id: character.id),
        ),
        expect: () => [
          const CharacterDetailsLoading(),
          CharacterDetailsSuccess(character: character),
        ],
      );

      blocTest<CharacterDetailsPageBloc, CharacterDetailsPageState>(
        'emits [CharacterDetailsSuccess] when CharacterDetailsSet is added',
        build: () => bloc,
        act: (bloc) => bloc.add(
          CharacterDetailsSet(character: character),
        ),
        expect: () => [
          CharacterDetailsSuccess(character: character),
        ],
      );

      blocTest<CharacterDetailsPageBloc, CharacterDetailsPageState>(
        'emits [CharacterDetailsLoading, is a failure] '
        'when an exception is thrown',
        build: () {
          when(
            () => mockGetCharacterByID.call(
              id: any<int>(named: 'id'),
            ),
          ).thenThrow(
            (_) => Exception(),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(
          CharacterDetailsFetch(id: character.id),
        ),
        expect: () => [
          const CharacterDetailsLoading(),
        ],
      );
    },
  );
}
