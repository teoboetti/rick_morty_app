part of 'character_search_page_bloc.dart';

sealed class CharacterSearchPageEvent extends Equatable {
  const CharacterSearchPageEvent();

  @override
  List<Object?> get props => [];
}

final class CharacterSearchEvent extends CharacterSearchPageEvent {
  const CharacterSearchEvent({
    required this.name,
  });

  final String name;

  @override
  List<Object?> get props => [
        name,
      ];
}

final class CharacterSearchNextPage extends CharacterSearchPageEvent {
  const CharacterSearchNextPage();
}

final class CharacterClearSearchEvent extends CharacterSearchPageEvent {}
