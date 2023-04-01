import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ideathon_concept_app/pages/map_view_page.dart';

Color _m3SeedColor = Colors.red.shade800;

class IdeathonConceptApp extends ConsumerWidget {
  const IdeathonConceptApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      themeMode: ThemeMode.system,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: _m3SeedColor)),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark, seedColor: _m3SeedColor),
      ),
      home: const ShuttlePathMapViewConsumerScreen(),
    );
  }
}
