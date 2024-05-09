import 'package:flutter/material.dart';
import 'package:Fusion/router/router.dart';
import 'theme/theme.dart';

class Fusion extends StatelessWidget {
  const Fusion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fusion',
      theme: FusionTheme,
      routes: routes,
    );
  }
}
