import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockResponse<T> extends Mock implements Response<T> {
  MockResponse({T? data}) : _data = data;

  final T? _data;

  @override
  T? get data => _data;
}
