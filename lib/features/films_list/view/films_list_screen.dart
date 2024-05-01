// import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/blurred_app_bar.dart';
import '../widgets/film_tile.dart';
import '/repositories/films_repo/models/Film.dart';
import '/repositories/films_repo/films_repository.dart';

class FilmsListScreen extends StatefulWidget {
  @override
  _FilmsScreenState createState() => _FilmsScreenState();
}

class _FilmsScreenState extends State<FilmsListScreen> {
  late Future<List<Film>> _filmsFuture;

  @override
  void initState() {
    super.initState();
    _filmsFuture = FilmsRepository().getFilmsList();
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
            return ListView.builder(
              padding: const EdgeInsets.only(top: 16),
              itemCount: filmsList.length,
              itemBuilder: (context, index) {
                final film = filmsList[index];
                return FilmTile(film: film);
              },
            );
          }
        },
      ),
    );
  }
}
