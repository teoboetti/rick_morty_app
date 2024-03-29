import 'package:json_annotation/json_annotation.dart';

part 'location_dto.g.dart';

/// {@template location}
/// Location model
/// {@endtemplate}
@JsonSerializable()
class LocationDto {
  /// {@macro location}
  const LocationDto({
    required this.name,
  });

  /// {@macro location} from json
  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);

  /// The name of the location.
  final String name;

  /// toJson
  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
}
