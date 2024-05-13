// ignore_for_file: file_names, non_constant_identifier_names

class Reviews {
  final int id;
  final String user;
  final String message;
  final DateTime createdAt;
  final int likesCount;

  Reviews({
    required this.id,
    required this.user,
    required this.message,
    required this.createdAt,
    required this.likesCount,
  });
}
