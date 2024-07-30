import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'person_model.dart';

class PersonDatabaseProvider {
  final String _personDatabaseName = "person_database.db";
  final int _version = 1;
  Database? database;

  Future<void> open() async {
    database = await openDatabase(
      join(await getDatabasesPath(), _personDatabaseName),
      version: _version,
      onCreate: (db, version) {
        createTable(db);
      },
    );
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      "CREATE TABLE person (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(30), phone VARCHAR(10))",
    );
  }

  Future<List<PersonModel>> getList() async {
    List<Map<String, dynamic>> personMaps = await database!.query("person");
    return personMaps.map((e) => PersonModel.fromJson(e)).toList();
  }

  Future<bool> insert(PersonModel model) async {
    final int id = await database!.insert('person', model.toJson());
    return id > 0;
  }

  Future<bool> delete(int id) async {
    final int count =
        await database!.delete('person', where: 'id = ?', whereArgs: [id]);
    return count > 0;
  }

  Future<bool> update(int id, PersonModel model) async {
    final int count = await database!.update(
      'person',
      model.toJson(),
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  Future<void> close() async {
    await database!.close();
  }
}
