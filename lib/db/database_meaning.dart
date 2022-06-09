import 'package:memorize/db/database.dart';
import 'package:memorize/model/meaning.dart';
import 'package:memorize/model/word.dart';

class MeaningOperations {
  DatabaseRepository dbRepository = DatabaseRepository.instance;

  Future<Meaning> createMeaning(Meaning meaning) async {
    final db = await dbRepository.database;

    final id = await db.insert(tableMeanings, meaning.toJson());
    return meaning.copy(id: id);
  }

  Future<int> updateMeaning(Meaning meaning) async {
    final db = await dbRepository.database;

    return db.update(
      tableMeanings,
      meaning.toJson(),
      where: '${MeaningFields.id} = ?',
      whereArgs: [meaning.id],
    );
  }

  Future<int> deleteMeaning(int? id) async{
    final db = await dbRepository.database;

    return await db.delete(
      tableMeanings,
      where: '${MeaningFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<List<Meaning>> getWordMeanings(int? wordID) async{
    final db = await dbRepository.database;

    const where = '${MeaningFields.wordId} = ?';

    var whereArgs = [wordID];

    final result = await db.query(
      tableMeanings,
      where: where,
      whereArgs: whereArgs
      );

      return result.map((json) => Meaning.fromJson(json)).toList();
  }
}