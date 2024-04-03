import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/domain/entity/info.dart';
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
          const CharactersPageInitial(),
        ) {
    on<FetchPageEvent>(
      (event, emit) async {
        if (state is CharacterPageSuccess) {
          await _fetchNextPage(event, emit, state as CharacterPageSuccess);
        } else {
          await _fetchFirstPage(event, emit);
        }
      },
      transformer: _throttleDroppable(
        const Duration(
          milliseconds: 100,
        ),
      ),
    );
  }

  final GetPaginatedCharacters _getPaginatedCharacters;

  Future<void> _fetchFirstPage(
    FetchPageEvent event,
    Emitter<CharactersPageState> emit,
  ) async {
    try {
      final result = await _getPaginatedCharacters(
        page: 1,
      );

      emit(
        CharacterPageSuccess(
          page: 1,
          info: result.info,
          characters: result.results,
        ),
      );
    } catch (e) {
      addError(e);
    }
  }

  Future<void> _fetchNextPage(
    FetchPageEvent event,
    Emitter<CharactersPageState> emit,
    CharacterPageSuccess state,
  ) async {
    try {
      /// if has no more pages prevent fetch
      if (!state.hasMoreToFetch) {
        return;
      }

      emit(
        CharacterPageSuccess(
          page: state.page,
          info: state.info,
          characters: state.characters,
        ),
      );

      final page = state.page + 1;

      final result = await _getPaginatedCharacters(
        page: page,
      );

      emit(
        CharacterPageSuccess(
          page: page,
          info: result.info,
          characters: state.characters
            ..addAll(
              result.results,
            ),
        ),
      );
    } catch (e) {
      addError(e);
    }
  }
}
