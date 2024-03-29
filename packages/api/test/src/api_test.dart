// ignore_for_file: prefer_const_constructors
import 'package:api/api.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../mocks/dio_mock.dart';
import '../mocks/uri_mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  group(
    'Api',
    () {
      test('can be instantiated', () {
        final dio = Dio();

        expect(ApiImpl(dio), isNotNull);
      });

      test(
        'Should make a successful API call with default parameters',
        () async {
          final mockDio = MockDio();
          final api = ApiImpl(mockDio);

          final response = MockResponse<Map<String, dynamic>>(
            data: {
              'info': {
                'count': 826,
                'pages': 42,
              },
              'results': [
                {
                  'id': 1,
                  'name': 'Rick Sanchez',
                  'status': 'Alive',
                  'species': 'Human',
                  'type': '',
                  'gender': 'Male',
                  'origin': {
                    'name': 'Earth',
                    'url': 'https://rickandmortyapi.com/api/location/1',
                  },
                  'location': {
                    'name': 'Earth',
                    'url': 'https://rickandmortyapi.com/api/location/20',
                  },
                  'image':
                      'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
                  'episode': [
                    'https://rickandmortyapi.com/api/episode/1',
                    'https://rickandmortyapi.com/api/episode/2',
                  ],
                  'url': 'https://rickandmortyapi.com/api/character/1',
                  'created': '2017-11-04T18:48:46.250Z',
                },
              ],
            },
          );

          when(
            () => mockDio.getUri<Map<String, dynamic>>(
              any(),
            ),
          ).thenAnswer(
            (_) async => response,
          );

          final result = await api.getPaginatedCharacters();
          expect(result, isA<PaginationDto>());
        },
      );

      test(
        'Should throw TypeError',
        () async {
          final mockDio = MockDio();
          final api = ApiImpl(mockDio);

          final response = MockResponse<Map<String, dynamic>>(
            data: {},
          );

          when(
            () => mockDio.getUri<Map<String, dynamic>>(
              any(),
            ),
          ).thenAnswer(
            (_) async => response,
          );

          await expectLater(
            api.getPaginatedCharacters,
            throwsA(isA<TypeError>()),
          );
        },
      );
    },
  );
}
