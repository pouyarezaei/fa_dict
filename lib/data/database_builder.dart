import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseBuilder {
  static const DB_NAME = "dic.sqlite";
  static const DB_VERSION = 1;

  static Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, DB_NAME);
    print(dbPath);
    // copy db file from Assets folder to Documents folder (only if not already there...)
    if (FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound) {
      print("db file notFound in $dbPath");
      ByteData data = await rootBundle.load("assets/$DB_NAME");
      _writeToFile(data, dbPath);
    }
    print("db file copied to $dbPath");
    // Open/create the database at a given path
    Database database = await openDatabase(dbPath, version: DB_VERSION,
        onCreate: (Database db, int version) async {
      await db.rawQuery(
          "CREATE TABLE IF NOT EXISTS history(id INTEGER PRIMARY KEY,word_id INTEGER,FOREIGN KEY (word_id) REFERENCES en_fa (id) ON DELETE CASCADE ON UPDATE NO ACTION);");
    });
    return database;
  }

  static Future<Database> loadDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, DB_NAME);
    // Open/create the database at a given path
    return openDatabase(dbPath);
  }

  // HERE IS WHERE THE CODE CRASHES (WHEN TRYING TO WRITE THE LOADED BYTES)
  static void _writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytesSync(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
