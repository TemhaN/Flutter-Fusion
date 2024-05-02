import 'package:flutter/material.dart';
import '../widgets/blurred_app_bar.dart';
import '../widgets/film_tile.dart';
import '/repositories/films_repo/models/Film.dart';
import '/repositories/films_repo/films_repository.dart';

class FilmsListScreen extends StatefulWidget {
  @override
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
      appBar: BlurredAppBar(),
      body: FutureBuilder<List<Film>>(
        future: _filmsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final filmsList = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.white10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home_filled, color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(Icons.search_rounded, color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
                onPressed: () => _onItemTapped(1),
              ),
              IconButton(
                icon: Icon(Icons.person_3, color: _selectedIndex == 2 ? Colors.blue : Colors.grey),
                onPressed: () => _onItemTapped(2),
              ),
            ],
          ),
        ),
      )
    );
  }
}
