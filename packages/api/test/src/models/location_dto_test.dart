import 'package:api/src/models/location_dto.dart';
import 'package:test/test.dart';

void main() {
  test('LocationDto', () {
    const name = 'Test Location';

    const location = LocationDto(name: name);

    expect(location.name, equals(name));
  });
}
