class FilmDetails {
  final int id;
  final String name;
  final int year_of_issue;
  final double ratingAvg;
  final String link_img;
  final String link_video;
  final int age;
  final int duration;
  // Добавьте другие свойства фильма, если необходимо

  FilmDetails({
    required this.id,
    required this.name,
    required this.year_of_issue,
    required this.ratingAvg,
    required this.link_img,
    required this.link_video,
    required this.age,
    required this.duration,
    // Добавьте другие свойства фильма, если необходимо
  });

  factory FilmDetails.fromJson(Map<String, dynamic> json) {
    return FilmDetails(
      id: json['id'],
      name: json['name'],
      year_of_issue: int.parse(json['year_of_issue']),
      ratingAvg: (json['ratingAvg'] ?? 0).toDouble(),
      link_img: json['link_img'],
      link_video: json['link_video'],
      age: json['age'],
      duration: json['duration'],
      // Добавьте другие свойства фильма, если необходимо
    );
  }
}
