import 'package:Fusion/repositories/films_repo/models/Actors.dart';
import 'package:Fusion/repositories/films_repo/models/FilmDetail.dart';
import 'package:Fusion/repositories/films_repo/models/Reviews.dart';
import 'package:dio/dio.dart';
import '/api/api_config.dart';
import 'models/Film.dart';

class FilmsRepository {
  Future<List<Film>> getFilmsList() async {
    final response = await Dio().get('${ApiConfig.baseUrl}/films');

    final data = response.data as Map<String, dynamic>;
    final filmsList = (data['films'] as List<dynamic>)
        .map((filmData) => Film(
              id: filmData['id'],
              name: filmData['name'],
              year_of_issue: int.parse(filmData['year_of_issue']),
              ratingAvg: (filmData['ratingAvg'] ?? 0).toDouble(),
              link_img: filmData['link_img'],
            ))
        .toList();
    return filmsList;
  }

  Future<FilmDetails> getFilmDetailsById(int id) async {
    final response = await Dio().get('${ApiConfig.baseUrl}/film/$id');

    final data = response.data as Map<String, dynamic>;
    return FilmDetails.fromJson(data);
  }

  Future<List<Actor>> getActorsByFilmId(int id) async {
    final actorsResponse =
        await Dio().get('${ApiConfig.baseUrl}/film/$id/actors');

    final actorsData = actorsResponse.data as Map<String, dynamic>;

    return List<Actor>.from(
      actorsData['actors']?.map(
            (actor) => Actor(
              name: actor['name'],
              img_link: actor['img_link'],
            ),
          ) ??
          [],
    );
  }

  Future<List<Reviews>> getReviewsByFilmId(int id) async {
    try {
      final response = await Dio().get('${ApiConfig.baseUrl}/film/$id/reviews');

      final reviewsData = response.data['reviews'] as List<dynamic>;

      final List<Reviews> reviews = reviewsData.map((review) {
        return Reviews(
          id: review['id'],
          user: review['user']['fio'],
          message: review['message'],
          createdAt: review['created_at'] != null
              ? DateTime.parse(review['created_at'])
              : DateTime.now(),
          likesCount: review['likesCount'],
        );
      }).toList();
      return reviews;
    } catch (e) {
      return [];
    }
  }
}
