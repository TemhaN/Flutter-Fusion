import 'dart:ui';

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
                          height: MediaQuery.of(context).size.width * 9 / 16,
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
                      padding: const EdgeInsets.fromLTRB(25.0, 35.0, 26.0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  filmDetails.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_border_outlined,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '${filmDetails.ratingAvg}',
                                    style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: Colors.yellow,
                                              fontSize: 17,
                                            ) ??
                                        TextStyle(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${filmDetails.year_of_issue}',
                            style: TextStyle(
                              color: Colors.white12,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  '${filmDetails.country}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${filmDetails.duration} мин.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Wrap(
                            spacing: 2,
                            children: filmDetails.categories
                                .map((category) => Chip(
                                      label: Text(
                                        category,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.grey[800],
                                    ))
                                .toList(),
                          ),
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
