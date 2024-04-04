import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/domain/entity/pagination.dart';

abstract class ICharacterRepository {
  Future<Pagination> getPaginatedCharacters({int page = 0});

  Future<Character> getByID({required int id});

  Future<Pagination> searchCharacter({
    required String name,
    int page = 0,
  });
}
