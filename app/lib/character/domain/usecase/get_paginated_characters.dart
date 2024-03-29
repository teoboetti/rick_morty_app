import 'package:rick_morty_app/character/domain/entity/pagination.dart';
import 'package:rick_morty_app/character/domain/repository/i_character_repository.dart';

class GetPaginatedCharacters {
  GetPaginatedCharacters({
    required ICharacterRepository repository,
  }) : _repository = repository;

  final ICharacterRepository _repository;

  Future<Pagination> call({int page = 0}) {
    return _repository.getPaginatedCharacters(page: page);
  }
}
