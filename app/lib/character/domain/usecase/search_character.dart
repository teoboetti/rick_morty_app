import 'package:rick_morty_app/character/character.dart';
import 'package:rick_morty_app/character/domain/repository/i_character_repository.dart';

class SearchCharacter {
  SearchCharacter({
    required ICharacterRepository repository,
  }) : _repository = repository;

  final ICharacterRepository _repository;

  Future<Pagination> call({
    required String name,
    int page = 0,
  }) {
    return _repository.searchCharacter(
      name: name,
      page: page,
    );
  }
}
