import 'package:flutter/material.dart';
import 'package:flutter_fusion/repositories/films_repo/models/Film.dart';

class FilmTile extends StatelessWidget {
  const FilmTile({
    Key? key,
    required this.film,
  }) : super(key: key);

  final Film film;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Image.network(
        film.link_img,
        height: 450,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/image.png',
          height: 150,
        ),
      ),
      title: Text(
        film.name,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        '${film.year_of_issue}',
        style: theme.textTheme.labelSmall,
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        Navigator.of(context).pushNamed('/film');
      },
    );
  }
}
