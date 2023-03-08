import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ideathon_concept_app/routes/map_view_page.dart';

class IdeathonConceptApp extends ConsumerWidget {
  const IdeathonConceptApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent)),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark, seedColor: Colors.red.shade600),
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor:
                Theme.of(context).colorScheme.background.withOpacity(0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26.0),
                    topRight: Radius.circular(26.0)))),
      ),
      home: const Scaffold(body: ShuttlePathMapViewConsumerScreen()),
    );
  }
}
