import 'package:sqflite/sqflite.dart';
import 'person_model.dart';

class PersonDatabaseProvider {
  final String _personDatabaseName = "person";
  final int _version = 1;
  late Database database;

  Future<void> open() async {
    database = await openDatabase(_personDatabaseName, version: _version,
        onCreate: (db, version) {
      createTable(db);
    });
  }

  Future<void> createTable(Database db) async {
    await db.execute(
        "CREATE TABLE person (id INTEGER PRIMARY KEY AUTOINCREMENT , name VARCHAR(30) , phone VARCHAR(10))");
  }

  Future<List<PersonModel>> getList() async {
    List<Map<String, dynamic>> personMaps = await database.query("person");
    return personMaps.map((e) => PersonModel.fromJson(e)).toList();
  }

  Future<bool> insert(PersonModel model) async {
    final personMaps = await database.insert('person', model.toJson());

    return personMaps != null;
  }

  Future<bool> delete(int id) async {
    final personMaps =
        await database.delete('person', where: 'id = ?', whereArgs: [id]);

    return personMaps != null;
  }

  Future<bool> update(int id, PersonModel model) async {
    final personMaps = await database
        .update('person', model.toJson(), where: 'id = ?', whereArgs: [id]);

    return personMaps != null;
  }

  Future<void> close() async {
    await database.close();
  }
}
