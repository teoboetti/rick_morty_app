import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/domain/entity/gender.dart';
import 'package:rick_morty_app/character/domain/entity/location.dart';
import 'package:rick_morty_app/character/domain/entity/status.dart';
import 'package:rick_morty_app/character/domain/usecase/get_character_by_id.dart';
import 'package:rick_morty_app/character/presentation/details/character_details.dart';
import 'package:rick_morty_app/components/loading.dart';

import '../../../../helpers/helpers.dart';
import '../../../../mocks/usecases.dart';

class MockCharacterDetailsPageBloc
    extends MockBloc<CharacterDetailsPageEvent, CharacterDetailsPageState>
    implements CharacterDetailsPageBloc {}

void main() {
  late MockGetCharacterByID getCharacterByID;
  late MockCharacterDetailsPageBloc bloc;
  late Character character;

  setUpAll(
    () {
      getCharacterByID = MockGetCharacterByID();
      bloc = MockCharacterDetailsPageBloc();
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

  group(
    'Character Details Page:',
    () {
      testWidgets(
        'should call getCharacterByID if character is null',
        (tester) async {
          await tester.pumpApp(
            RepositoryProvider<GetCharacterByID>.value(
              value: getCharacterByID,
              child: const CharacterDetailsPage(cid: 1),
            ),
          );

          verify(
            () => getCharacterByID.call(id: 1),
          ).called(1);
        },
      );
    },
  );

  group(
    'Character Details View:',
    () {
      testWidgets(
        'should not call getCharacterByID if character != null',
        (tester) async {
          await tester.pumpApp(
            RepositoryProvider<GetCharacterByID>.value(
              value: getCharacterByID,
              child: CharacterDetailsPage(
                cid: 1,
                character: character,
              ),
            ),
          );

          verifyNever(
            () => getCharacterByID.call(id: 1),
          );
        },
      );

      testWidgets(
        'should show a loading',
        (tester) async {
          when(() => bloc.state).thenReturn(
            const CharacterDetailsLoading(),
          );

          await tester.pumpApp(
            RepositoryProvider<GetCharacterByID>.value(
              value: getCharacterByID,
              child: BlocProvider<CharacterDetailsPageBloc>.value(
                value: bloc,
                child: const CharacterDetailsView(),
              ),
            ),
          );

          expect(find.byType(Loading), findsOneWidget);
        },
      );

      testWidgets(
        'should show details',
        (tester) async {
          when(() => bloc.state).thenReturn(
            CharacterDetailsSuccess(
              character: character,
            ),
          );

          await tester.pumpApp(
            RepositoryProvider<GetCharacterByID>.value(
              value: getCharacterByID,
              child: BlocProvider<CharacterDetailsPageBloc>.value(
                value: bloc,
                child: const CharacterDetailsView(),
              ),
            ),
          );

          expect(find.byType(Loading), findsNothing);

          expect(find.byType(SingleChildScrollView), findsOneWidget);
        },
      );
    },
  );
}
