import 'package:memorize/db/database.dart';
import 'package:memorize/model/archive.dart';

class ArchiveOperations {
  DatabaseRepository dbRepository = DatabaseRepository.instance;

  Future<Archive> createArchive(Archive archive) async {
    final db = await dbRepository.database;

    final id = await db.insert(tableArchives, archive.toJson());
    return archive.copy(id: id);
  }

  Future<int> updateArchive(Archive archive) async {
    final db = await dbRepository.database;

    return db.update(
      tableArchives,
      archive.toJson(),
      where: '${ArchiveFields.id} = ?',
      whereArgs: [archive.id],
    );
  }

  Future<int> deleteArchive(int? id) async {
    final db = await dbRepository.database;

    return await db.delete(
      tableArchives,
      where: '${ArchiveFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<Archive> getArchive(int? archiveID) async {
    final db = await dbRepository.database;

    const where = '${ArchiveFields.id} = ?';

    var whereArgs = [archiveID];

    final query =
        await db.query(tableArchives, where: where, whereArgs: whereArgs);

    final result = query.map((json) => Archive.fromJson(json)).toList();

    return result.first;
  }

  Future<List<Archive>> getArchives() async {
    final db = await dbRepository.database;

    const orderBy = '${ArchiveFields.time} ASC';

    final result = await db.query(
      tableArchives,
      orderBy: orderBy,
    );

    return result.map((json) => Archive.fromJson(json)).toList();
  }

  Future<List<Archive>> getPinnedArchives() async {
    final db = await dbRepository.database;

    const orderBy = '${ArchiveFields.time} ASC';

    const where = '${ArchiveFields.isPinned} = ?';

    const whereArgs = [1];

    final result = await db.query(tableArchives,
        orderBy: orderBy, where: where, whereArgs: whereArgs);

    return result.map((json) => Archive.fromJson(json)).toList();
  }

  Future<List<Archive>> getNormalArchives() async {
    final db = await dbRepository.database;

    const orderBy = '${ArchiveFields.time} ASC';

    const where = '${ArchiveFields.isPinned} = ?';

    const whereArgs = [0];

    final result = await db.query(tableArchives,
        orderBy: orderBy, where: where, whereArgs: whereArgs);

    return result.map((json) => Archive.fromJson(json)).toList();
  }

  Future<List<Archive>> getAllArchives() async {
    final db = await dbRepository.database;

    const orderBy = '${ArchiveFields.time} ASC';

    final result = await db.query(
      tableArchives,
      orderBy: orderBy,
    );

    return result.map((json) => Archive.fromJson(json)).toList();
  }
}
