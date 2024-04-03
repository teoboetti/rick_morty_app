part of 'characters_page_bloc.dart';

sealed class CharactersPageState extends Equatable {
  const CharactersPageState();

  @override
  List<Object?> get props => [];
}

final class CharactersPageInitial extends CharactersPageState {
  const CharactersPageInitial();
}

final class CharacterPageSuccess extends CharactersPageState {
  const CharacterPageSuccess({
    required this.page,
    required this.info,
    required this.characters,
  });

  final int page;

  final Info info;

  final List<Character> characters;

  bool get hasMoreToFetch {
    return page <= info.pages;
  }

  @override
  List<Object?> get props => [
        page,
        info,
        characters,
      ];
}
