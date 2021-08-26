part of 'word_search_bloc.dart';

@immutable
abstract class WordSearchState {
  late final List<WordEntity> searchResult;

  WordSearchState({required this.searchResult});
}

class EmptyWordSearchState extends WordSearchState {
  EmptyWordSearchState() : super(searchResult: List.empty());
}

class WordSearchResultState extends WordSearchState {
  WordSearchResultState({required List<WordEntity> searchResult})
      : super(searchResult: searchResult);
}

class HistorySearchResultState extends WordSearchState {
  HistorySearchResultState({required List<WordEntity> searchResult})
      : super(searchResult: searchResult);
}

class SentenceSearchResultState extends WordSearchState {
  late final String sentenceSearchResult;

  SentenceSearchResultState(
      {required List<WordEntity> searchResult,
      required this.sentenceSearchResult})
      : super(searchResult: searchResult);
}
