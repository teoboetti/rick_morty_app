import 'package:api/api.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/domain/entity/pagination.dart';
import 'package:rick_morty_app/character/domain/repository/i_character_repository.dart';

class CharacterRepositoryImpl extends ICharacterRepository {
  CharacterRepositoryImpl({
    required IApi api,
  }) : _api = api;

  final IApi _api;

  @override
  Future<Pagination> getPaginatedCharacters({
    int page = 0,
  }) async {
    final result = await _api.getPaginatedCharacters(page: page);

    return result.toDomain();
  }

  @override
  Future<Character> getByID({required int id}) async {
    final result = await _api.getByID(id: id);

    return result.toDomain();
  }

  @override
  Future<Pagination> searchCharacter({
    required String name,
    int page = 0,
  }) async {
    final result = await _api.searchCharacter(
      name: name,
      page: page,
    );

    return result.toDomain();
  }
}
