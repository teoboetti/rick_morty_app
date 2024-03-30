import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_morty_app/character/domain/entity/character.dart';

part 'character_details_page_event.dart';
part 'character_details_page_state.dart';

class CharacterDetailsPageBloc
    extends Bloc<CharacterDetailsPageEvent, CharacterDetailsPageState> {
  CharacterDetailsPageBloc({required Character character})
      : super(
          CharacterDetailsPageState(
            character: character,
          ),
        );
}
