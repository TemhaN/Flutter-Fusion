// ignore_for_file: non_constant_identifier_names, file_names

class FilmDetails {
  final int id;
  final String name;
  final int year_of_issue;
  final double ratingAvg;
  final String link_img;
  final String link_video;
  final int age;
  final int duration;
  final List<String> categories;
  final String country;

  FilmDetails({
    required this.id,
    required this.name,
    required this.year_of_issue,
    required this.ratingAvg,
    required this.link_img,
    required this.link_video,
    required this.age,
    required this.duration,
    required this.categories,
    required this.country,
  });

  factory FilmDetails.fromJson(Map<String, dynamic> json) {
    List<String> categories = List<String>.from(
        json['categories']?.map((category) => category['name']) ?? []);

    String country = json['country']['name'].toString();

    return FilmDetails(
      id: json['id'],
      name: json['name'],
      year_of_issue: int.parse(json['year_of_issue']),
      ratingAvg: (json['ratingAvg'] ?? 0).toDouble(),
      link_img: json['link_img'],
      link_video: json['link_video'],
      age: json['age'],
      duration: json['duration'],
      categories: categories,
      country: country,
    );
  }
}
