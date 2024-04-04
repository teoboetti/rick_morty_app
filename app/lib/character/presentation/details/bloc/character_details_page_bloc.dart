import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';
import 'package:rick_morty_app/character/domain/usecase/get_character_by_id.dart';

part 'character_details_page_event.dart';
part 'character_details_page_state.dart';

class CharacterDetailsPageBloc
    extends Bloc<CharacterDetailsPageEvent, CharacterDetailsPageState> {
  CharacterDetailsPageBloc({
    required GetCharacterByID getCharacterByID,
  })  : _getCharacterByID = getCharacterByID,
        super(
          const CharacterDetailsInitial(),
        ) {
    on<CharacterDetailsSet>(_setCharacter);
    on<CharacterDetailsFetch>(_fetchCharacter);
  }

  final GetCharacterByID _getCharacterByID;

  void _setCharacter(
    CharacterDetailsSet event,
    Emitter<CharacterDetailsPageState> emit,
  ) {
    emit(
      CharacterDetailsSuccess(
        character: event.character,
      ),
    );
  }

  Future<void> _fetchCharacter(
    CharacterDetailsFetch event,
    Emitter<CharacterDetailsPageState> emit,
  ) async {
    try {
      emit(const CharacterDetailsLoading());

      final character = await _getCharacterByID.call(
        id: event.id,
      );

      emit(
        CharacterDetailsSuccess(
          character: character,
        ),
      );
    } catch (e) {
      addError(e);
    }
  }
}
