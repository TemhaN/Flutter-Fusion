import 'package:flutter/material.dart';

class DetailFilmScreen extends StatefulWidget {
  const DetailFilmScreen({super.key});

  @override
  State<DetailFilmScreen> createState() => _DetailFilmScreenState();
}

class _DetailFilmScreenState extends State<DetailFilmScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Чел пук')),
    );
  }
}
