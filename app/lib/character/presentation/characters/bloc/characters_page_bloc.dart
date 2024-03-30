import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/domain/entity/pagination.dart';
import 'package:rick_morty_app/character/domain/usecase/get_paginated_characters.dart';
import 'package:stream_transform/stream_transform.dart';

part 'characters_page_event.dart';
part 'characters_page_state.dart';

EventTransformer<E> _throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharactersPageBloc
    extends Bloc<CharactersPageEvent, CharactersPageState> {
  CharactersPageBloc({
    required GetPaginatedCharacters getPaginatedCharacters,
  })  : _getPaginatedCharacters = getPaginatedCharacters,
        super(
          const CharactersPageInitial(page: 1),
        ) {
    on<FetchPageEvent>(
      _fetchPage,
      transformer: _throttleDroppable(
        const Duration(
          milliseconds: 100,
        ),
      ),
    );
  }

  final GetPaginatedCharacters _getPaginatedCharacters;

  Future<void> _fetchPage(
    FetchPageEvent event,
    Emitter<CharactersPageState> emit,
  ) async {
    try {
      if (state is CharacterPageSuccess) {
        final characterPageSuccess = state as CharacterPageSuccess;

        /// if has no more pages prevent fetch
        if (!characterPageSuccess.hasMoreToFetch) {
          return;
        }

        emit(
          characterPageSuccess.copyWith(
            hasReachedEnd: true,
          ),
        );

        final page = state.page + 1;

        final result = await _getPaginatedCharacters(
          page: page,
        );

        emit(
          characterPageSuccess.copyWith(
            page: page,
            pagination: characterPageSuccess.pagination.copyWith(
              results: characterPageSuccess.characters
                ..addAll(
                  result.results,
                ),
            ),
            hasReachedEnd: false,
          ),
        );
      } else {
        final result = await _getPaginatedCharacters(
          page: state.page,
        );

        emit(
          CharacterPageSuccess(
            page: state.page,
            pagination: result,
            hasReachedEnd: false,
          ),
        );
      }
    } catch (e) {
      addError(e);
    }
  }
}
