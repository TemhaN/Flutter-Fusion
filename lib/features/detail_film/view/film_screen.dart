// ignore_for_file: unnecessary_import

import 'dart:ui';

import 'package:Fusion/repositories/films_repo/models/Actors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '/repositories/films_repo/models/FilmDetail.dart';
import '/repositories/films_repo/films_repository.dart';

class FilmDetailsScreen extends StatelessWidget {
  const FilmDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int id = args['id'];
    return FutureBuilder(
      future: FilmsRepository().getFilmDetailsById(id),
      builder: (BuildContext context, AsyncSnapshot<FilmDetails> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error loading film details')),
          );
        } else {
          final filmDetails = snapshot.data!;

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
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
                              handleColor: Colors.black54,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
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
                          top: 16,
                          right: 16,
                          child: IconButton(
                            icon: const Icon(FontAwesomeIcons.heart,
                                size: 25, color: Colors.white),
                            onPressed: () {},
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
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_border_outlined,
                                    color: Colors.yellow,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${filmDetails.ratingAvg}',
                                    style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: Colors.yellow,
                                              fontSize: 17,
                                            ) ??
                                        const TextStyle(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${filmDetails.year_of_issue}',
                            style: const TextStyle(
                              color: Colors.white12,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  filmDetails.country,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${filmDetails.duration} мин.',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            children: filmDetails.categories
                                .map((category) => Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Chip(
                                        label: Text(
                                          category,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        backgroundColor: Colors.grey[800],
                                      ),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 20),
                          FutureBuilder(
                            future: FilmsRepository().getActorsByFilmId(id),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Actor>> actorSnapshot) {
                              if (actorSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (actorSnapshot.hasError) {
                                return const Text('Error loading actors');
                              } else {
                                final actors = actorSnapshot.data!;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Актеры:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: actors
                                          .map(
                                            (actor) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 13),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            actor.img_link),
                                                    radius: 20,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    actor.name,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                );
                              }
                            },
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
