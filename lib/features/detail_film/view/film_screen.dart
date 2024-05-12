import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '/repositories/films_repo/models/FilmDetail.dart';
import '/repositories/films_repo/films_repository.dart';

class FilmDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int id = args['id'];
    return FutureBuilder(
      future: FilmsRepository().getFilmDetailsById(id),
      builder: (BuildContext context, AsyncSnapshot<FilmDetails> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error loading film details')),
          );
        } else {
          final filmDetails = snapshot.data!;

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Изменили на start
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width *
                              9 /
                              16, // Пропорции плеера 16:9
                          child: YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId: filmDetails.link_video,
                              flags: const YoutubePlayerFlags(
                                autoPlay: true,
                                mute: false,
                                hideControls: false,
                              ),
                            ),
                            showVideoProgressIndicator: true,
                            progressColors: const ProgressBarColors(
                                playedColor: Color(0xFFE779B5),
                                handleColor: Colors.black54),
                          ),
                        ),
                        Positioned(
                          top: 16, // Отступ от верхнего края
                          left: 16,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                size: 25, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Positioned(
                          top: 16, // Отступ от верхнего края
                          right: 16,
                          child: IconButton(
                            icon: const Icon(FontAwesomeIcons.heart,
                                size: 25, color: Colors.white),
                            onPressed: () {
                              // Действия по нажатию на кнопку "Еще"
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filmDetails.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Year of Issue: ${filmDetails.year_of_issue}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Rating: ${filmDetails.ratingAvg}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Age: ${filmDetails.age}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Duration: ${filmDetails.duration}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          // Добавьте другие детали фильма, если необходимо
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
