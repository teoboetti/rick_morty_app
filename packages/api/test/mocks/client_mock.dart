import 'package:api/api.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheStore extends Fake implements CacheStore {}

class MockCacheOptions extends Fake implements CacheOptions {}

class MockApiClient extends Mock implements ApiClient {}

class MockDio extends Mock implements Dio {}

class MockResponse<T> extends Mock implements Response<T> {
  MockResponse({T? data}) : _data = data;

  final T? _data;

  @override
  T? get data => _data;
}
