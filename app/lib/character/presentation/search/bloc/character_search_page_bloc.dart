import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_morty_app/character/character.dart';
import 'package:stream_transform/stream_transform.dart';

part 'character_search_page_event.dart';
part 'character_search_page_state.dart';

EventTransformer<E> _throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharacterSearchPageBloc
    extends Bloc<CharacterSearchPageEvent, CharacterSearchPageState> {
  CharacterSearchPageBloc({
    required SearchCharacter searchCharacter,
  })  : _searchCharacter = searchCharacter,
        super(
          const CharacterSearchPageInitial(page: 1),
        ) {
    on<CharacterSearchEvent>(
      _search,
      transformer: _throttleDroppable(
        const Duration(milliseconds: 250),
      ),
    );
    on<CharacterSearchNextPage>(
      _nextPage,
      transformer: _throttleDroppable(
        const Duration(milliseconds: 250),
      ),
    );
    on<CharacterClearSearchEvent>(_clearSearch);
  }

  final SearchCharacter _searchCharacter;

  Future<void> _search(
    CharacterSearchEvent event,
    Emitter<CharacterSearchPageState> emit,
  ) async {
    try {
      emit(
        CharacterSearchLoading(
          page: state.page,
        ),
      );

      final result = await _searchCharacter.call(
        name: event.name,
      );

      emit(
        CharacterSearchSuccess(
          query: event.name,
          page: state.page,
          pagination: result,
          hasReachedEnd: false,
        ),
      );
    } catch (e) {
      addError(e);

      emit(
        const CharacterSearchNotFound(),
      );
    }
  }

  Future<void> _nextPage(
    CharacterSearchNextPage event,
    Emitter<CharacterSearchPageState> emit,
  ) async {
    try {
      if (state is CharacterSearchSuccess) {
        final characterSearchSuccess = state as CharacterSearchSuccess;

        if (!characterSearchSuccess.hasMoreToFetch) {
          return;
        }

        emit(
          characterSearchSuccess.copyWith(
            hasReachedEnd: true,
          ),
        );

        final page = state.page + 1;

        final result = await _searchCharacter(
          name: characterSearchSuccess.query,
          page: page,
        );

        emit(
          characterSearchSuccess.copyWith(
            page: page,
            pagination: characterSearchSuccess.pagination.copyWith(
              results: characterSearchSuccess.characters
                ..addAll(
                  result.results,
                ),
            ),
            hasReachedEnd: false,
          ),
        );
      }
    } catch (e) {
      addError(e);
    }
  }

  void _clearSearch(
    CharacterClearSearchEvent event,
    Emitter<CharacterSearchPageState> emit,
  ) {
    emit(const CharacterSearchPageInitial(page: 1));
  }
}
