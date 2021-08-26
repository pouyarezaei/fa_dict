part of 'word_search_bloc.dart';

@immutable
abstract class WordSearchEvent {}

class WordEqualitySearchEvent extends WordSearchEvent {
  late final String word;
  late final String wordColumn;

  WordEqualitySearchEvent({required this.word, required this.wordColumn})
      : super();
}

class WordLikeSearchEvent extends WordSearchEvent {
  late final String word;
  late final String wordColumn;

  WordLikeSearchEvent({required this.word, required this.wordColumn}) : super();
}

class FavoriteWordEvent extends WordSearchEvent {
  FavoriteWordEvent() : super();
}

class HistoryWordEvent extends WordSearchEvent {
  HistoryWordEvent() : super();
}

class SentenceTranslateEvent extends WordSearchEvent {
  late final List<String> words;

  SentenceTranslateEvent({required this.words}) : super();
}

class UpdateWordEvent extends WordSearchEvent {
  late final String word;

  UpdateWordEvent({required this.word}) : super();
}

class RemoveFavoriteWordEvent extends WordSearchEvent {
  late final String word;

  RemoveFavoriteWordEvent({required this.word}) : super();
}

class AddFavoriteWordEvent extends WordSearchEvent {
  late final String word;

  AddFavoriteWordEvent({required this.word}) : super();
}

class EmptyWordEvent extends WordSearchEvent {
  EmptyWordEvent() : super();
}
