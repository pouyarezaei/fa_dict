/// EnglishWord : "a few"
/// PersianWord : "کمي"

class WordEntity {
  static const String WordEntityTable = "en_fa";
  static const String EnglishWordColumn = "en";
  static const String PersianWordColumn = "fa";
  static const String IsFavWordColumn = "isFav";
  late String _englishWord;
  late String _persianWord;
  late int _isFav;

  String get englishWord => _englishWord;

  String get persianWord => _persianWord;

  int get isFav => _isFav;

  WordEntity(
      {required String englishWord,
      required String persianWord,
      required int isFav}) {
    _englishWord = englishWord;
    _persianWord = persianWord;
    _isFav = isFav;
  }

  WordEntity.fromMap(Map<String, dynamic> json) {
    _englishWord = json[EnglishWordColumn];
    _persianWord = json[PersianWordColumn];
    _isFav = json[IsFavWordColumn];
  }

  WordEntity.fromJson(dynamic json) {
    _englishWord = json[EnglishWordColumn];
    _persianWord = json[PersianWordColumn];
    _isFav = json[IsFavWordColumn];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[EnglishWordColumn] = _englishWord;
    map[PersianWordColumn] = _persianWord;
    map[IsFavWordColumn] = _isFav;
    return map;
  }

  @override
  String toString() {
    return 'WordEntity{_englishWord: $_englishWord, _persianWord: $_persianWord}';
  }
}
