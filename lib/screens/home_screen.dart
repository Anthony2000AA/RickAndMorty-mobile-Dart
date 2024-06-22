
import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter_project/screens/character_list_favorite.dart';
import 'package:rick_and_morty_flutter_project/screens/character_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;
  final List<Widget> _children = [
    const CharacterListScreen(),
    const CharacterListFavorite()
   // Container(color: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (value) => {
          setState(() {
            currentIndex = value;
          })
        },
      )
    );
  }
}