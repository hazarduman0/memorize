import 'package:memorize/db/database.dart';
import 'package:memorize/db/database_meaning.dart';
import 'package:memorize/model/word.dart';

class WordOperations {
  MeaningOperations meaningOperations = MeaningOperations();
  DatabaseRepository dbRepository = DatabaseRepository.instance;

  Future<Word> createWord(Word word) async {
    final db = await dbRepository.database;

    final id = await db.insert(tableWords, word.toJson());
    return word.copy(id: id);
  }

  Future<int> updateWord(Word word) async {
    final db = await dbRepository.database;

    return db.update(
      tableWords,
      word.toJson(),
      where: '${WordFields.id} = ?',
      whereArgs: [word.id],
    );
  }

  Future<int> deleteWord(int? id) async {
    final db = await dbRepository.database;

    return await db.delete(
      tableWords,
      where: '${WordFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<Word?> getLastWord(int? archiveId) async {
    final db = await dbRepository.database;

    const where = '${WordFields.archiveID} = ?';

    var whereArgs = [archiveId];

    var orderBy = '${WordFields.time} DESC';

    final _wordResult = await db.query(tableWords,
        where: where, whereArgs: whereArgs, orderBy: orderBy, limit: 1);

    return _wordResult.map((json) => Word.fromJson(json)).toList().first;
  }

  Future<List<Word>> getWord(int? wordID) async {
    final db = await dbRepository.database;

    const where = '${WordFields.id} = ?';

    var whereArgs = [wordID];

    final result =
        await db.query(tableWords, where: where, whereArgs: whereArgs);

    return result.map((json) => Word.fromJson(json)).toList();
  }

  Future<int?> getWordWithMeaningCount(int? archiveID) async {
    final db = await dbRepository.database;

    const where = '${WordFields.archiveID} = ?';

    var whereArgs = [archiveID];

    final result =
        await db.query(tableWords, where: where, whereArgs: whereArgs);
    var _list = result.map((json) => Word.fromJson(json)).toList();
    int _wordWithMeaningCount = 0;

    for (int i = 0; i < _list.length; i++) {
      int? _meaningCount = await meaningOperations.getMeaningCount(_list[i].id);
      if (_meaningCount! > 0) {
        _wordWithMeaningCount++;
      }
    }

    return _wordWithMeaningCount;
  }

  Future<int?> getWordCount(int? archiveId) async {
    final db = await dbRepository.database;

    const where = '${WordFields.archiveID} = ?';

    var whereArgs = [archiveId];

    final result =
        await db.query(tableWords, where: where, whereArgs: whereArgs);
    var _list = result.map((json) => Word.fromJson(json)).toList();

    return _list.isEmpty ? 0 : _list.length;
  }

  Future<List<Word>> getArchiveWords(int? archiveID) async {
    final db = await dbRepository.database;

    const where = '${WordFields.archiveID} = ?';

    var whereArgs = [archiveID];

    final result =
        await db.query(tableWords, where: where, whereArgs: whereArgs);
    return result.map((json) => Word.fromJson(json)).toList();
  }

  Future<List<Word>> getSortedArchiveWords(
      int? archiveID, String sortBy) async {
    final db = await dbRepository.database;

    const where = '${WordFields.archiveID} = ?';

    var whereArgs = [archiveID];

    var orderBy = sortBy == 'Alfabetik'
        ? WordFields.word
        : sortBy == 'Son Olu??turulan'
            ? '${WordFields.time} DESC'
            : '${WordFields.time} ASC';

    final result = await db.query(tableWords,
        where: where, whereArgs: whereArgs, orderBy: orderBy);
    return result.map((json) => Word.fromJson(json)).toList();
  }
}
