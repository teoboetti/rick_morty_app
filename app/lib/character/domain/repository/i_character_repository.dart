import 'package:rick_morty_app/character/domain/entity/pagination.dart';

abstract class ICharacterRepository {
  Future<Pagination> getPaginatedCharacters({int page = 0});

  Future<Pagination> searchCharacter({
    required String name,
    int page = 0,
  });
}
