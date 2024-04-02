import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class ApiClient {
  const ApiClient({
    required this.cacheStore,
    required this.cacheOptions,
    required this.dio,
  });

  final CacheStore cacheStore;

  final CacheOptions cacheOptions;

  final Dio dio;
}
