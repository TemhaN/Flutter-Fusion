import 'package:Fusion/repositories/films_repo/films_repository.dart';
import 'package:Fusion/repositories/films_repo/models/FilmDetail.dart';
import 'package:flutter/material.dart';
import 'package:Fusion/repositories/films_repo/models/Film.dart';

class FilmTile extends StatelessWidget {
  const FilmTile({
    Key? key,
    required this.film,
  }) : super(key: key);

  final Film film;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/film',
          arguments: {'id': film.id},
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      film.link_img,
                      height: 350,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/image.png',
                        height: 275,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_border_outlined,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${film.ratingAvg}',
                        style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.yellow,
                              fontSize: 17,
                            ) ??
                            TextStyle(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    film.name,
                    style: theme.textTheme.labelLarge
                            ?.copyWith(color: Colors.white) ??
                        TextStyle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${film.year_of_issue}',
                    style: theme.textTheme.labelSmall
                            ?.copyWith(color: Colors.white54) ??
                        TextStyle(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
