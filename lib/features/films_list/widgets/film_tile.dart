import 'package:flutter/material.dart';

class FilmTile extends StatelessWidget {
  const FilmTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Image.asset(
        'assets/images/image.png',
        height: 150,
      ),
      title: Text(
        'Человек паук: через вселенные',
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        'Крутой фильм',
        style: theme.textTheme.labelSmall,
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        Navigator.of(context).pushNamed('/film');
      },
    );
  }
}
