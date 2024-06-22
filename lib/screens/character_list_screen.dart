
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rick_and_morty_flutter_project/dao/character_dao.dart';
import 'package:rick_and_morty_flutter_project/models/character.model.dart';
import 'package:rick_and_morty_flutter_project/services/character_service.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      body:  CharacterList(),
    );
  }
}





class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {

  final CharacterService _characterService = CharacterService();
  static const _pageSize = 20;

  final PagingController<int, dynamic> _pagingController = 
        PagingController(firstPageKey: 1);

  @override
  void initState() {//inicializa el estado del widget
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  _fetchPage(int pageKey) async {
    try {
      final newItems = await _characterService.getAllCharacters(pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int,dynamic>(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0
      ),
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, character, index)=> 
          CharacterItem(
            character: character
          ),
      ),
      
    );

  }
}




class CharacterItem extends StatefulWidget {
  const CharacterItem({super.key, required this.character});

  final Character  character;

  @override
  State<CharacterItem> createState() => _CharacterItemState();
}

class _CharacterItemState extends State<CharacterItem> {
  
  bool _isFavorite = false;
 final CharacterDao _characterDao = CharacterDao();

 initialize()async {
   _isFavorite = await _characterDao.isFavorite(widget.character);
   print(_isFavorite);
   setState(() {
     _isFavorite = _isFavorite;
   });
 }

  @override
  void initState() {
    initialize();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    MaterialColor color;
    switch(widget.character.status){
      case 'Alive':
        color = Colors.green;
        break;
      case 'Dead':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
        break;
    }

    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child:
                Text(
                 widget.character.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8.0
                  ),
                 maxLines: 1,
                 overflow: TextOverflow.clip,
                ),
            
          ),
          Expanded(child: Image.network( widget.character.image )),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    
                        Icon(
                          Icons.circle,
                          size: 12.0,
                          color: color,
                        ),
                        Text(widget.character.species),
                        
     
                  ]
                ),
                
              ],
            ),
            
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 IconButton(
                  icon: Icon(
                    Icons.favorite,color: _isFavorite ? Colors.red : Colors.grey,
                    size: 16.0,
                    ),
                
                  onPressed: (){
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                    _isFavorite
                      ? _characterDao.insert(widget.character)
                      : _characterDao.delete(widget.character);
///
                      /////imprimir en consola los personajes favoritos
                      _characterDao.getAllFavorites().then((value) => print(value));
                  },
          
               )  
              ]
            )
        ],
      ),
    );
  }
}