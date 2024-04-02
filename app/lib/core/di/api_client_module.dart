import 'package:api/api.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ApiClientModule {
  @lazySingleton
  ApiClient get apiClient {
    final cacheStore = HiveCacheStore(null);

    final cacheOptions = CacheOptions(
      store: cacheStore,
      hitCacheOnErrorExcept: [401, 403],
    );

    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://rickandmortyapi.com',
      ),
    );

    dio.interceptors.add(
      DioCacheInterceptor(options: cacheOptions),
    );

    return ApiClient(
      cacheStore: cacheStore,
      cacheOptions: cacheOptions,
      dio: dio,
    );
  }
}
