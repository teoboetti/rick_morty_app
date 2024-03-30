part of 'character_details_page_bloc.dart';

final class CharacterDetailsPageState extends Equatable {
  const CharacterDetailsPageState({
    required this.character,
  });

  final Character character;

  @override
  List<Object?> get props => [character];
}
