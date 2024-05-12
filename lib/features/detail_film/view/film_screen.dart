import '/repositories/films_repo/models/FilmDetail.dart';
import 'package:flutter/material.dart';
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
            appBar: AppBar(
              title: Text('Film Details'),
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Film Details'),
            ),
            body: Center(child: Text('Error loading film details')),
          );
        } else {
          final filmDetails = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Film Details'),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Здесь можно отобразить изображение фильма, название, год выпуска, рейтинг и другие детали
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      filmDetails.link_img,
                      height: 350,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/image.png',
                        height: 275,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
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
          );
        }
      },
    );
  }
}
