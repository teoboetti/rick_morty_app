part of 'character_search_page_bloc.dart';

sealed class CharacterSearchPageState extends Equatable {
  const CharacterSearchPageState({
    required this.page,
  });

  final int page;

  @override
  List<Object?> get props => [];
}

final class CharacterSearchPageInitial extends CharacterSearchPageState {
  const CharacterSearchPageInitial({
    required super.page,
  });
}

final class CharacterSearchLoading extends CharacterSearchPageState {
  const CharacterSearchLoading({
    required super.page,
  });
}

final class CharacterSearchSuccess extends CharacterSearchPageState {
  const CharacterSearchSuccess({
    required super.page,
    required this.query,
    required this.pagination,
    required this.hasReachedEnd,
  });

  final String query;

  final Pagination pagination;

  final bool hasReachedEnd;

  List<Character> get characters => pagination.results;

  bool get hasMoreToFetch {
    return page <= pagination.info.pages;
  }

  CharacterSearchSuccess copyWith({
    String? query,
    int? page,
    Pagination? pagination,
    bool? hasReachedEnd,
  }) {
    return CharacterSearchSuccess(
      page: page ?? this.page,
      query: query ?? this.query,
      pagination: pagination ?? this.pagination,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  @override
  List<Object?> get props => [
        pagination,
      ];
}

final class CharacterSearchNotFound extends CharacterSearchPageState {
  const CharacterSearchNotFound({
    super.page = 0,
  });
}
