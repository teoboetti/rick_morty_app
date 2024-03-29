import 'package:json_annotation/json_annotation.dart';

part 'info_dto.g.dart';

/// {@template info}
/// info model
/// {@endtemplate}
@JsonSerializable()
class InfoDto {
  /// {@macro info}
  const InfoDto({
    required this.count,
    required this.pages,
  });

  /// {@macro info} from json
  factory InfoDto.fromJson(Map<String, dynamic> json) =>
      _$InfoDtoFromJson(json);

  /// The length of the response
  final int count;

  /// The amount of pages
  final int pages;

  /// toJson
  Map<String, dynamic> toJson() => _$InfoDtoToJson(this);
}
