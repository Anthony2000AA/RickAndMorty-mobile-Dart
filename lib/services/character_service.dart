
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_flutter_project/models/character.model.dart';

class CharacterService{
  final String _baseUrl = 'https://rickandmortyapi.com/api/character';

  Future<List<Character>> getAllCharacters(int page) async {
    final http.Response response = await http.get(Uri.parse("$_baseUrl?page=$page"));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      final apiResponse = ApiResponse.fromJson(jsonResponse);

      print("El info del response es: ${apiResponse.info}");
      print("El results del response es: ${apiResponse.results}");

      //imprimir en consola el nombre de los personajes
      apiResponse.results.forEach((character) {
        print(character.name);
      });
      
      
      return apiResponse.results;





    } else {
      throw Exception('Failed to load characters');
    }
  }

}