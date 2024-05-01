import 'package:flutter/material.dart';
import 'package:flutter_fusion/router/router.dart';
import 'theme/theme.dart';

class Fusion extends StatelessWidget {
  const Fusion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FilmsList',
      theme: filmTheme,
      routes: routes,
    );
  }
}
