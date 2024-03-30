import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/domain/entity/gender.dart';
import 'package:rick_morty_app/character/domain/entity/info.dart';
import 'package:rick_morty_app/character/domain/entity/location.dart';
import 'package:rick_morty_app/character/domain/entity/pagination.dart';
import 'package:rick_morty_app/character/domain/entity/status.dart';
import 'package:rick_morty_app/character/domain/usecase/get_paginated_characters.dart';
import 'package:rick_morty_app/character/presentation/characters/characters.dart';
import 'package:rick_morty_app/components/character_tile.dart';
import 'package:rick_morty_app/components/loading.dart';

import '../../../../helpers/helpers.dart';

class MockPaginatedCharacters extends Mock implements GetPaginatedCharacters {}

class MockCharactersPageBloc
    extends MockBloc<CharactersPageEvent, CharactersPageState>
    implements CharactersPageBloc {}

void main() {
  group(
    'Characters View',
    () {
      late MockPaginatedCharacters getPaginatedCharacter;
      late MockCharactersPageBloc bloc;

      setUp(
        () {
          getPaginatedCharacter = MockPaginatedCharacters();
          bloc = MockCharactersPageBloc();
        },
      );

      testWidgets(
        'Characters Page should show a list in success',
        (tester) async {
          when(() => bloc.state).thenAnswer(
            (_) => CharacterPageSuccess(
              page: 1,
              pagination: Pagination(
                info: Info(
                  pages: 1,
                  count: 20,
                ),
                results: List.generate(
                  20,
                  (index) => Character(
                    id: index,
                    name: 'name',
                    status: CharacterStatus.alive,
                    species: 'species',
                    type: 'type',
                    gender: CharacterGender.genderless,
                    origin: Location(
                      name: 'name',
                    ),
                    location: Location(
                      name: 'name',
                    ),
                    image: 'image',
                    episode: [],
                    url: 'url',
                    created: DateTime.now(),
                  ),
                ),
              ),
              hasReachedEnd: true,
            ),
          );

          await tester.pumpApp(
            RepositoryProvider<GetPaginatedCharacters>.value(
              value: getPaginatedCharacter,
              child: BlocProvider<CharactersPageBloc>.value(
                value: bloc,
                child: const CharactersView(),
              ),
            ),
          );

          expect(find.byType(CharacterTile), findsWidgets);
        },
      );

      testWidgets(
        'Characters View should show a loading in initial state',
        (tester) async {
          when(() => bloc.state).thenReturn(
            const CharactersPageInitial(page: 0),
          );

          await tester.pumpApp(
            RepositoryProvider<GetPaginatedCharacters>.value(
              value: getPaginatedCharacter,
              child: BlocProvider<CharactersPageBloc>.value(
                value: bloc,
                child: const CharactersView(),
              ),
            ),
          );

          expect(find.byType(Loading), findsOneWidget);
        },
      );
    },
  );
}
