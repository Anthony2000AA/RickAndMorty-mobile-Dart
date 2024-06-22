
import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter_project/dao/character_dao.dart';

class CharacterListFavorite extends StatefulWidget {
  const CharacterListFavorite({super.key});

  @override
  State<CharacterListFavorite> createState() => _CharacterListFavoriteState();
}

class _CharacterListFavoriteState extends State<CharacterListFavorite> {

  List _favoritesCharacter =[];

  initalize()async{
     _favoritesCharacter = await CharacterDao().getAllFavorites();
      setState(() {
        
        _favoritesCharacter = _favoritesCharacter;
        print(_favoritesCharacter.length);

      });
  }

  @override
  void initState() {
    initalize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      //si la lista de favoritos esta vacia
         _favoritesCharacter.isEmpty ?
            const Center(
              child: Text("No hay favoritos"),

           )
           : 
           ListView.builder(
           itemCount: _favoritesCharacter.length,
           itemBuilder: (context, index) {
             return Card(
               child: ListTile(
                 title: Text(_favoritesCharacter[index].name),
                 subtitle: Text(_favoritesCharacter[index].status),
                 leading: Image.network(_favoritesCharacter[index].image),
               ),
             );
           },
         )
    );
  }
}