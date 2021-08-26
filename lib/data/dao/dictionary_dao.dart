import 'package:fa_dict/data/database_builder.dart';
import 'package:fa_dict/data/entity/word_entity.dart';
import 'package:sqflite/sqflite.dart';

class DictionaryDao {

  Future<List<WordEntity>> wordLikeSearch(
      String word, String wordColumn) async {
    Database database = await DatabaseBuilder.loadDatabase();

    List<Map<String, dynamic>> maps =
        await database.query(WordEntity.WordEntityTable,
            groupBy: WordEntity.EnglishWordColumn,
            orderBy: 'length(${WordEntity.EnglishWordColumn})',
            columns: [
              WordEntity.EnglishWordColumn,
              WordEntity.PersianWordColumn,
              WordEntity.IsFavWordColumn
            ],
            where: "$wordColumn like ?",
            whereArgs: ["$word%"]);
    print(maps.length);
    return List.generate(
        maps.length, (index) => WordEntity.fromMap(maps[index]));
  }

  Future<List<WordEntity>> wordEqualSearch(
      String word, String wordColumn) async {
    Database database = await DatabaseBuilder.loadDatabase();

    List<Map<String, dynamic>> maps =
        await database.query(WordEntity.WordEntityTable,
            columns: [
              WordEntity.EnglishWordColumn,
              WordEntity.PersianWordColumn,
              WordEntity.IsFavWordColumn
            ],
            where: "$wordColumn= ?",
            whereArgs: [word]);

    return List.generate(
        maps.length, (index) => WordEntity.fromMap(maps[index]));
  }

  Future<List<WordEntity>> favoriteWords() async {
    Database database = await DatabaseBuilder.loadDatabase();

    List<Map<String, dynamic>> maps =
        await database.query(WordEntity.WordEntityTable,
            groupBy: WordEntity.EnglishWordColumn,
            orderBy: 'length(${WordEntity.EnglishWordColumn})',
            columns: [
              WordEntity.EnglishWordColumn,
              WordEntity.PersianWordColumn,
              WordEntity.IsFavWordColumn
            ],
            where: "${WordEntity.IsFavWordColumn} = ?",
            whereArgs: [1]);
    print(maps.length);
    print(maps);

    return List.generate(
        maps.length, (index) => WordEntity.fromMap(maps[index]));
  }

  Future<int> updateFavorite(bool isFav, String word) async {
    Database database = await DatabaseBuilder.loadDatabase();
    //update en_fa SET isFav = 1 WHERE en="word";
    int affectedRow = await database.rawUpdate(
        "UPDATE ${WordEntity.WordEntityTable} SET isFav = ? WHERE en= ? ",
        [isFav ? 1 : 0, word]);
    return affectedRow;
  }

  Future<List<WordEntity>> searchedWord() async {
    Database database = await DatabaseBuilder.loadDatabase();
    //update en_fa SET isFav = 1 WHERE en="word";
    List<Map<String, dynamic>> maps = await database.rawQuery(
        "SELECT en_fa.* from en_fa,history where en_fa.id = history.word_id;");
    return List.generate(
        maps.length, (index) => WordEntity.fromMap(maps[index]));
  }
}
