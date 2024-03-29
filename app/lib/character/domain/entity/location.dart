import 'package:api/api.dart';

class Location {
  Location({
    required this.name,
  });

  /// The name of the location.
  final String name;
}

extension LocationDtoX on LocationDto {
  Location toDomain() {
    return Location(name: name);
  }
}
