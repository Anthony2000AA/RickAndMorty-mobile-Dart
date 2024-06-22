import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{
  final int version = 1;
  final String databaseName = 'rickandmorty.databaseFinal';
  final String characterTable = 'character';

  Database? _database;

  Future<Database> openDB()async {
   _database ??= await openDatabase(
    join(await getDatabasesPath(), databaseName),
    onCreate:(db, version){
      String query = "create table $characterTable (id integer primary key, name text, status text, species text, type text, gender text, image text, url text, created text)";
      db.execute(query);
    },
    version: version

    );

    return _database as Database;
  }
  

}