import 'package:api/src/api_client.dart';
import 'package:api/src/models/character_dto.dart';
import 'package:api/src/models/pagination_dto.dart';
import 'package:flutter/foundation.dart';

/// {@template api}
/// Api
/// {@endtemplate}
abstract class IApi {
  /// get character paginated
  Future<PaginationDto> getPaginatedCharacters({
    int page = 0,
  });

  /// get character by id
  Future<CharacterDto> getByID({required int id});

  /// search character by query
  Future<PaginationDto> searchCharacter({
    required String name,
    int page = 0,
  });
}

/// {@template api.impl}
/// Api Implementation
/// {@endtemplate}
final class ApiImpl implements IApi {
  /// {@macro api.impl}
  const ApiImpl(this.client);

  /// client that makes the Api calls
  @visibleForTesting
  final ApiClient client;

  @override
  Future<PaginationDto> getPaginatedCharacters({
    int page = 0,
  }) async {
    try {
      final uri = Uri(
        path: '/api/character',
        queryParameters: {
          'page': '$page',
        },
      );

      final response = await client.dio.getUri<Map<String, dynamic>>(
        uri,
      );

      return PaginationDto.fromJson(response.data!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CharacterDto> getByID({required int id}) async {
    try {
      final uri = Uri(
        path: '/api/character/$id',
      );

      final response = await client.dio.getUri<Map<String, dynamic>>(uri);

      return CharacterDto.fromJson(response.data!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PaginationDto> searchCharacter({
    required String name,
    int page = 0,
  }) async {
    try {
      final uri = Uri(
        path: '/api/character',
        queryParameters: {
          'name': name,
          'page': '$page',
        },
      );

      final response = await client.dio.getUri<Map<String, dynamic>>(
        uri,
      );

      return PaginationDto.fromJson(response.data!);
    } catch (e) {
      rethrow;
    }
  }
}
