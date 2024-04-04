part of 'character_details_page_bloc.dart';

sealed class CharacterDetailsPageState extends Equatable {
  const CharacterDetailsPageState();

  @override
  List<Object?> get props => [];
}

final class CharacterDetailsInitial extends CharacterDetailsPageState {
  const CharacterDetailsInitial();
}

final class CharacterDetailsLoading extends CharacterDetailsPageState {
  const CharacterDetailsLoading();
}

final class CharacterDetailsSuccess extends CharacterDetailsPageState {
  const CharacterDetailsSuccess({
    required this.character,
  });

  final Character character;

  @override
  List<Object?> get props => [character];
}
