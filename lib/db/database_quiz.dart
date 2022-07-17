import 'package:memorize/db/database.dart';
import 'package:memorize/model/meaning.dart';
import 'package:memorize/model/quiz.dart';
import 'package:memorize/model/word.dart';

class QuizOperations {
  DatabaseRepository dbRepository = DatabaseRepository.instance;

  Future<Map<String,List<String>>> getRandomWordsAndAnswers(int? archiveID, int? questionAmaount) async{
    final db = await dbRepository.database;

    const wordWhere = '${WordFields.archiveID} = ?';
    const meaningWhere = '${MeaningFields.wordId} = ?';

    var wordWhereArgs = [archiveID];

    var random = 'RANDOM()';

    Map<String,List<String>> _wordsAndAnswers = {};

    for(int i = 0; i < questionAmaount!; i++){
      final _wordResult = await db.query(
      tableWords,
      where: wordWhere,
      whereArgs: wordWhereArgs,
      orderBy: random,
      limit: 1,
    );

    Word _wordObj = _wordResult.map((json) => Word.fromJson(json)).toList().first;

    var meaningWhereArgs = [_wordObj.id];

    final _meaningResult = await db.query(
      tableMeanings,
      where: meaningWhere,
      whereArgs: meaningWhereArgs
    );

    var _meaningListResult = _meaningResult.map((json) => Meaning.fromJson(json).meaning).toList();

    if(_wordsAndAnswers[_wordObj.word] == null){
      _wordsAndAnswers[_wordObj.word] = _meaningListResult;
    }
    else{
      i--;
    }
    
    }

    return _wordsAndAnswers;
  }

  Future<int?> getQuizCount(int? archiveID) async{
    final db = await dbRepository.database;

    const where = '${QuizFields.archiveID} = ?';

    var whereArgs = [archiveID];

    final result = await db.query(
      tableQuizs,
      where: where,
      whereArgs: whereArgs
      );
    var _list = result.map((json) => Quiz.fromJson(json)).toList();

    return _list.isEmpty ? 0 : _list.length;  
  }
}
