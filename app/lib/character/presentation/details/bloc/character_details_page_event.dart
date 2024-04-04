part of 'character_details_page_bloc.dart';

sealed class CharacterDetailsPageEvent extends Equatable {
  const CharacterDetailsPageEvent();

  @override
  List<Object?> get props => [];
}

final class CharacterDetailsSet extends CharacterDetailsPageEvent {
  const CharacterDetailsSet({
    required this.character,
  });

  final Character character;

  @override
  List<Object?> get props => [character];
}

final class CharacterDetailsFetch extends CharacterDetailsPageEvent {
  const CharacterDetailsFetch({
    required this.id,
  });

  final int id;

  @override
  List<Object?> get props => [id];
}
