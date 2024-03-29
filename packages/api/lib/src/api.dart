import 'package:api/src/models/pagination_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// {@template api}
/// Api
/// {@endtemplate}
abstract class IApi {
  /// get character paginated
  Future<PaginationDto> getPaginatedCharacters({
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
  final Dio client;

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

      final response = await client.getUri<Map<String, dynamic>>(
        uri,
      );

      return PaginationDto.fromJson(response.data!);
    } catch (e) {
      rethrow;
    }
  }
}
