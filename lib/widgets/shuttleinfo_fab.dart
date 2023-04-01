import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'package:ideathon_concept_app/providers/fab_extended_provider.dart';
import 'package:ideathon_concept_app/providers/location_data_provider.dart'
    show locationDataProvider, currentLocationProvider;

class ShuttleInfoFABWidget extends ConsumerStatefulWidget {
  const ShuttleInfoFABWidget(
      {required this.draggableScrollableController, super.key});
  final DraggableScrollableController draggableScrollableController;

  @override
  ConsumerState<ShuttleInfoFABWidget> createState() =>
      _ShuttleInfoFABWidgetState();
}

class _ShuttleInfoFABWidgetState extends ConsumerState<ShuttleInfoFABWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> curve;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    curve = CurvedAnimation(parent: controller, curve: Curves.easeInOutSine);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<LatLng?> currentLocation = ref.watch(locationDataProvider);
    // if (currentLocation.hasValue) controller.forward();
    colorAnimation = ColorTween(
            begin: Theme.of(context).colorScheme.surface,
            end: Theme.of(context).colorScheme.primaryContainer)
        .animate(curve);
    if (!currentLocation.isLoading) {
      controller.forward();
    }
    return AnimatedSize(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOutSine,
      clipBehavior: Clip.none,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => FloatingActionButton.extended(
          icon: child,
          label: Text(currentLocation.hasValue ? "Track" : ''),
          isExtended: ref.watch(fabExtendedProvider),
          backgroundColor: colorAnimation.value,
          onPressed: currentLocation.hasValue
              ? _controlDraggableSheetOnPress
              : currentLocation.hasError
                  ? _requestEssentialPermissions
                  : null,
        ),
        child: Icon(currentLocation.hasError
            ? Icons.location_disabled_rounded
            : Icons.airport_shuttle_rounded),
      ),
    );
  }

  void _controlDraggableSheetOnPress() {
    if (widget.draggableScrollableController.isAttached) {
      double? size;
      if (widget.draggableScrollableController.size > 0) {
        size = 0;
      }
      widget.draggableScrollableController.animateTo(size ?? .25,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutSine);
    }
  }

  void _requestEssentialPermissions() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    ref.watch(currentLocationProvider).enablePermission();
    ref.watch(currentLocationProvider).enableService();
    SnackBar snackBar = const SnackBar(
      content: Text("Asking for permissions"),
      margin: EdgeInsets.only(right: 12, left: 16, top: 8, bottom: 8),
      elevation: 3,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 4500),
    );
    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
