
import 'package:rick_and_morty_flutter_project/database/app_database.dart';
import 'package:rick_and_morty_flutter_project/models/character.model.dart';
import 'package:sqflite/sqflite.dart';

class CharacterDao{
  insert(Character character) async {
    Database db = await AppDatabase().openDB();
    await db.insert(AppDatabase().characterTable, character.toMap());
  }

  //delete
  delete(Character character) async {
    Database db = await AppDatabase().openDB();
    await db.delete(AppDatabase().characterTable, where: "id = ?", whereArgs: [character.id]);
  }

  //isFavorite
  Future<bool> isFavorite(Character character) async {
    Database db = await AppDatabase().openDB();
    List result = await db.query(AppDatabase().characterTable, where: "id = ?", whereArgs: [character.id]);
    return result.isNotEmpty;
  }

  //getAllFavorites
  Future<List<Character>> getAllFavorites() async {
    Database db = await AppDatabase().openDB();
    List<Map<String, dynamic>> result = await db.query(AppDatabase().characterTable);
    return List.generate(result.length, (index) {
      return Character(
        id: result[index]['id'],
        name: result[index]['name'],
        status: result[index]['status'],
        species: result[index]['species'],
        type: result[index]['type'],
        gender: result[index]['gender'],
        image: result[index]['image'],
        url: result[index]['url'],
        created: result[index]['created']

        );
      }
  );
  
  
  }
}