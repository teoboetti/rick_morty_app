import 'package:api/api.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/domain/entity/info.dart';

class Pagination {
  Pagination({
    required this.info,
    required this.results,
  });

  /// Pagination infos
  final Info info;

  /// [Character] list
  final List<Character> results;

  Pagination copyWith({
    List<Character>? results,
  }) {
    return Pagination(
      info: info,
      results: results ?? this.results,
    );
  }
}

extension PaginationDtoX on PaginationDto {
  Pagination toDomain() {
    return Pagination(
      info: info.toDomain(),
      results: results
          .map<Character>(
            (e) => e.toDomain(),
          )
          .toList(),
    );
  }
}
