import 'package:api/src/models/character_dto.dart';
import 'package:api/src/models/info_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_dto.g.dart';

/// {@template pagination}
/// Pagination model
/// {@endtemplate}
@JsonSerializable()
class PaginationDto {
  /// {@macro pagination}
  PaginationDto({
    required this.info,
    required this.results,
  });

  /// {@macro pagination} from json
  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);

  /// Pagination infos
  final InfoDto info;

  /// [CharacterDto] list
  final List<CharacterDto> results;

  /// toJson
  Map<String, dynamic> toJson() => _$PaginationDtoToJson(this);
}
