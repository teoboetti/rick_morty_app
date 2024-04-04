import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/domain/repository/i_character_repository.dart';

class GetCharacterByID {
  GetCharacterByID({
    required ICharacterRepository repository,
  }) : _repository = repository;

  final ICharacterRepository _repository;

  Future<Character> call({required int id}) {
    return _repository.getByID(id: id);
  }
}
