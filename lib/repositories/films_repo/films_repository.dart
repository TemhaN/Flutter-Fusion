import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
import '/api/api_config.dart';
import 'models/Film.dart';

class FilmsRepository {
  Future<List<Film>> getFilmsList() async {
    final response = await Dio().get('${ApiConfig.baseUrl}/films');

    final data = response.data as Map<String, dynamic>;
    final filmsList = (data['films'] as List<dynamic>)
        .map((filmData) => Film(
              name: filmData['name'],
              year_of_issue: int.parse(filmData['year_of_issue']),
              link_img: filmData['link_img'],
            ))
        .toList();
    return filmsList;
  }
}
