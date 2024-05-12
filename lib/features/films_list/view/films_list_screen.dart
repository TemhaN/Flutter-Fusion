// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/blurred_app_bar.dart';
import '../widgets/film_tile.dart';
import '/repositories/films_repo/models/Film.dart';
import '/repositories/films_repo/films_repository.dart';

class FilmsListScreen extends StatefulWidget {
  const FilmsListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FilmsListScreenState createState() => _FilmsListScreenState();
}

class _FilmsListScreenState extends State<FilmsListScreen> {
  late Future<List<Film>> _filmsFuture;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _filmsFuture = FilmsRepository().getFilmsList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/');
          break;
        case 1:
          Navigator.pushNamed(context, '/search');
          break;
        case 2:
          Navigator.pushNamed(context, '/user');
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BlurredAppBar(),
        body: FutureBuilder<List<Film>>(
          future: _filmsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final filmsList = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.45,
                ),
                padding: const EdgeInsets.all(16),
                itemCount: filmsList.length,
                itemBuilder: (context, index) {
                  final film = filmsList[index];
                  return FilmTile(film: film);
                },
              );
            }
          },
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: Colors.white10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.house,
                      color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
                  onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.search,
                      color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
                  onPressed: () => _onItemTapped(1),
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.solidUser,
                      color: _selectedIndex == 2 ? Colors.blue : Colors.grey),
                  onPressed: () => _onItemTapped(2),
                ),
              ],
            ),
          ),
        ));
  }
}
