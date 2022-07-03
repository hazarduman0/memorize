import 'dart:async';

import 'package:memorize/model/archive.dart';
import 'package:memorize/model/meaning.dart';
import 'package:memorize/model/quiz.dart';
import 'package:memorize/model/word.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseRepository {
  static final DatabaseRepository instance = DatabaseRepository._init();

  static Database? _database;

  DatabaseRepository._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('deneme.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<int> deleteArchives() async {
    final db = await instance.database;

    return db.delete(tableArchives);
  }

  Future<int> deleteWord() async {
    final db = await instance.database;

    return db.delete(tableWords);
  }

  Future<int> deleteMeaning() async {
    final db = await instance.database;

    return db.delete(tableMeanings);
  }

  Future dropTable() async {
    final db = await instance.database;

    return db.rawQuery('DROP TABLE $tableArchives');
  }

  FutureOr _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const notNullableTextType = 'TEXT NOT NULL';
    const nullableTextType = 'TEXT';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute(''' 
    CREATE TABLE $tableArchives (
      ${ArchiveFields.id} $idType,
      ${ArchiveFields.isPinned} $boolType,
      ${ArchiveFields.archiveName} $notNullableTextType,
      ${ArchiveFields.description} $nullableTextType,
      ${ArchiveFields.color} $notNullableTextType,
      ${ArchiveFields.time} $notNullableTextType
    )
''');

    await db.execute(''' 
    CREATE TABLE $tableWords (
      ${WordFields.id} $idType,
      ${WordFields.archiveID} $integerType,
      ${WordFields.word} $notNullableTextType,
      ${WordFields.time} $notNullableTextType,
      FOREIGN KEY (${WordFields.archiveID}) REFERENCES $tableArchives (${ArchiveFields.id}) ON DELETE CASCADE
    )
''');

    await db.execute(''' 
    CREATE TABLE $tableMeanings (
      ${MeaningFields.id} $idType,
      ${MeaningFields.wordId} $integerType,
      ${MeaningFields.meaning} $notNullableTextType,
      ${MeaningFields.time} $notNullableTextType,
      FOREIGN KEY (${MeaningFields.wordId}) REFERENCES $tableWords (${WordFields.id}) ON DELETE CASCADE
    )
''');

    await db.execute('''
    CREATE TABLE $tableQuizs (
      ${QuizFields.id} $idType,
      ${QuizFields.archiveID} $integerType,
      ${QuizFields.trueCount} $integerType,
      ${QuizFields.falseCount} $integerType,
      ${QuizFields.noAnswerCount} $integerType,
      ${QuizFields.correctRate} $realType,
      ${QuizFields.wordCount} $integerType,
      ${QuizFields.counter} $notNullableTextType,
      ${QuizFields.date} $notNullableTextType,
      FOREIGN KEY (${QuizFields.archiveID} REFERENCES $tableArchives (${ArchiveFields.id}) ON DELETE CASCADE)
    )
 ''');
  }

  Future<void> deleDataBase() async {
    final dbPath = await getDatabasesPath();

    return await deleteDatabase(dbPath);
  }
}
