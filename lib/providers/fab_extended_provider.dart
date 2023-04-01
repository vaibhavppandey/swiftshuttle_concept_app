import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

StateNotifierProvider<FabExtendedStateNotifier, bool> fabExtendedProvider =
    StateNotifierProvider<FabExtendedStateNotifier, bool>(
        (_) => FabExtendedStateNotifier());
StateProvider<Color?> fabColor = StateProvider<Color?>((ref) => null);

class FabExtendedStateNotifier extends StateNotifier<bool> {
  FabExtendedStateNotifier() : super(false);

  void collapseFab() {
    state = false;
  }

  void extendFab() {
    state = true;
  }

  void switchFabState() {
    if (state) {
      collapseFab();
    } else {
      extendFab();
    }
  }
}
