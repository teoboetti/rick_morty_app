// ignore_for_file: prefer_const_constructors
import 'package:api/api.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  group('Api', () {
    test('can be instantiated', () {
      final dio = Dio();

      expect(ApiImpl(dio), isNotNull);
    });
  });
}
