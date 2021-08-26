import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fa_dict/data/dao/dictionary_dao.dart';
import 'package:fa_dict/data/entity/word_entity.dart';
import 'package:meta/meta.dart';

part 'word_search_event.dart';

part 'word_search_state.dart';

class WordSearchBloc extends Bloc<WordSearchEvent, WordSearchState> {
  WordSearchBloc() : super(EmptyWordSearchState());
  DictionaryDao _dictionaryDao = DictionaryDao();

  @override
  Stream<WordSearchState> mapEventToState(
    WordSearchEvent event,
  ) async* {
    if (event is WordLikeSearchEvent) {
      print("WordLikeSearchEvent");
      print("${event.word} , ${event.wordColumn}");
      List<WordEntity> words =
          await _dictionaryDao.wordLikeSearch(event.word, event.wordColumn);
      print("from bloc $words");
      yield WordSearchResultState(searchResult: words);
    }
    if (event is WordEqualitySearchEvent) {
      List<WordEntity> words =
          await _dictionaryDao.wordEqualSearch(event.word, event.wordColumn);
      yield WordSearchResultState(searchResult: words);
    }
    if (event is FavoriteWordEvent) {
      print("from bloc FavoriteWordEvent");
      List<WordEntity> words = await _dictionaryDao.favoriteWords();
      yield WordSearchResultState(searchResult: words);
      print("from bloc yield FavoriteWordEvent");
    }
    if (event is EmptyWordEvent) {
      print("from bloc EmptyWordEvent");
      yield EmptyWordSearchState();
      print("from bloc yield EmptyWordEvent");
    }
    if (event is RemoveFavoriteWordEvent) {
      print("from bloc RemoveFavoriteWordEvent");
      int affectedRow = await _dictionaryDao.updateFavorite(false, event.word);
      List<WordEntity> words = await _dictionaryDao.favoriteWords();

      yield WordSearchResultState(searchResult: words);

      print("from bloc yield RemoveFavoriteWordEvent affectedRow $affectedRow");
    }
    if (event is AddFavoriteWordEvent) {
      print("from bloc AddFavoriteWordEvent");
      int affectedRow = await _dictionaryDao.updateFavorite(true, (event).word);
      List<WordEntity> words = await _dictionaryDao.favoriteWords();
      yield WordSearchResultState(searchResult: words);
      print("from bloc yield AddFavoriteWordEvent affectedRow $affectedRow");
    }
    if (event is HistoryWordEvent) {
      print("from bloc HistoryWordEvent");
      List<WordEntity> words = await _dictionaryDao.searchedWord();
      yield WordSearchResultState(searchResult: words);
      print("from bloc yield HistoryWordEvent");
    }
    if (event is SentenceTranslateEvent) {
      print("from bloc SentenceTranslateEvent");
      String translate = "";
      for (var element in event.words) {
        List<WordEntity> words = await _dictionaryDao.wordEqualSearch(
            element, WordEntity.EnglishWordColumn);
        print(words.length);
        print(words);
        if (words.isNotEmpty) {
          translate += words.first.persianWord.trim() + " ";
        } else {
          translate += "? ";
        }
      }
      yield SentenceSearchResultState(
          searchResult: List.empty(), sentenceSearchResult: translate);
      print("from bloc yield SentenceTranslateEvent");
    }
  }
}
