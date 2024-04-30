import 'package:flutter/material.dart';

void main() {
  runApp(const Fusion());
}

class Fusion extends StatelessWidget {
  const Fusion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FilmsList',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 41, 41, 41),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(69, 70, 85, 1)),
        useMaterial3: true,
        dividerColor: Colors.white24,
        listTileTheme: const ListTileThemeData(iconColor: Colors.white),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 41, 41, 41),
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w700)),
        textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            labelSmall: TextStyle(
              color: Colors.white24,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            )),
      ),
      routes: {
        '/' :(context) => FilmsListScreen(),
        '/film' :(context) => DetailFilmScreen(),
      },
      // home: const FilmsListScreen(),
    );
  }
}

class FilmsListScreen extends StatefulWidget {
  const FilmsListScreen({super.key});

  @override
  State<FilmsListScreen> createState() => _FilmsListScreenState();
}

class _FilmsListScreenState extends State<FilmsListScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films List'),
      ),
      body: ListView.separated(
        itemCount: 20,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, i) => ListTile(
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
            Navigator.of(context);
          },
        ),
      ),
    );
  }
}

class DetailFilmScreen extends StatelessWidget {
  const DetailFilmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
