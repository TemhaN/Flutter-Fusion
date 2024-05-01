import 'package:flutter_fusion/features/detail_film/detail_film.dart';
import 'package:flutter_fusion/features/films_list/films_list.dart';

final routes = {
  '/': (context) => FilmsListScreen(),
  '/film': (context) => const DetailFilmScreen(),
};
