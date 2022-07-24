import 'package:memorize/constants/projectKeys.dart';
import 'package:memorize/db/database.dart';
import 'package:memorize/model/meaning.dart';
import 'package:memorize/model/quiz.dart';
import 'package:memorize/model/word.dart';

class QuizOperations {
  DatabaseRepository dbRepository = DatabaseRepository.instance;
  ProjectKeys keys = ProjectKeys();

  Future<Map<Word, List<Meaning>>> getWordsAndAnswers(
      int? archiveID, int? questionAmaount, String sortBy) async {
    final db = await dbRepository.database;

    const wordWhere = '${WordFields.archiveID} = ?';
    const meaningWhere = '${MeaningFields.wordId} = ?';

    var wordWhereArgs = [archiveID];

    var orderBy = sortBy == keys.random
        ? 'RANDOM()'
        : sortBy == keys.alphabetic
            ? WordFields.word
            : '${WordFields.time} DESC';

    Map<Word, List<Meaning>> _wordsAndAnswers = {};

    final _wordResult = await db.query(
      tableWords,
      where: wordWhere,
      whereArgs: wordWhereArgs,
      orderBy: orderBy,
    );

    List<Word> _wordList =
        _wordResult.map((json) => Word.fromJson(json)).toList();

    for (int i = 0; i < questionAmaount!; i++) {
      var meaningWhereArgs = [_wordList[i].id];
      final _meaningResult = await db.query(
        tableMeanings,
        where: meaningWhere,
        whereArgs: meaningWhereArgs,
      );

      List<Meaning> _meaningList =
          _meaningResult.map((json) => Meaning.fromJson(json)).toList();

      if (_meaningList.isEmpty) {
        _wordList.removeAt(i);
        i--;
      } else {
        _wordsAndAnswers[_wordList[i]] = _meaningList;
      }
    }

    return _wordsAndAnswers;
  }

  Future<int?> getQuizCount(int? archiveID) async {
    final db = await dbRepository.database;

    const where = '${QuizFields.archiveID} = ?';

    var whereArgs = [archiveID];

    final result =
        await db.query(tableQuizs, where: where, whereArgs: whereArgs);
    var _list = result.map((json) => Quiz.fromJson(json)).toList();

    return _list.isEmpty ? 0 : _list.length;
  }
}
