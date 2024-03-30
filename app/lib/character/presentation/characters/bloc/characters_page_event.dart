part of 'characters_page_bloc.dart';

sealed class CharactersPageEvent extends Equatable {
  const CharactersPageEvent();

  @override
  List<Object?> get props => [];
}

final class FetchPageEvent extends CharactersPageEvent {
  const FetchPageEvent();
}
