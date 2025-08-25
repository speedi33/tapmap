import 'package:flutter/material.dart';
import 'pages/map_page.dart';

class TapMapApp extends StatelessWidget {
  const TapMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TapMap',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MapPage(),
    );
  }
}
