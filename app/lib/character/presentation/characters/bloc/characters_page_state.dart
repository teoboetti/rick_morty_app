part of 'characters_page_bloc.dart';

sealed class CharactersPageState extends Equatable {
  const CharactersPageState({
    required this.page,
  });

  final int page;

  @override
  List<Object?> get props => [
        page,
      ];
}

final class CharactersPageInitial extends CharactersPageState {
  const CharactersPageInitial({
    required super.page,
  });
}

final class CharacterPageLoading extends CharactersPageState {
  const CharacterPageLoading({
    required super.page,
  });
}

final class CharacterPageSuccess extends CharactersPageState {
  const CharacterPageSuccess({
    required super.page,
    required this.pagination,
    required this.hasReachedEnd,
  });

  final Pagination pagination;

  final bool hasReachedEnd;

  List<Character> get characters => pagination.results;

  bool get hasMoreToFetch {
    return page <= pagination.info.pages;
  }

  CharacterPageSuccess copyWith({
    int? page,
    Pagination? pagination,
    bool? hasReachedEnd,
  }) {
    return CharacterPageSuccess(
      page: page ?? this.page,
      pagination: pagination ?? this.pagination,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  @override
  List<Object?> get props => [
        page,
        pagination,
      ];
}
