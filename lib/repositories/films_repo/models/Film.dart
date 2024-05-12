class Film {
  Film(
      {required this.id,
      required this.name,
      required this.year_of_issue,
      required this.ratingAvg,
      required this.link_img,});

  final int id;
  final String name;
  final int year_of_issue;
  final double ratingAvg;
  final String link_img;
}
