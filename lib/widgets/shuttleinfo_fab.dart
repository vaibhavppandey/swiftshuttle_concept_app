import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ideathon_concept_app/widgets/draggable_shuttle_info_sheet.dart';

class ShuttleInfoFABWidget extends ConsumerStatefulWidget {
  const ShuttleInfoFABWidget(
      {required this.draggableScrollableController, super.key});
  final DraggableScrollableController draggableScrollableController;

  @override
  ConsumerState<ShuttleInfoFABWidget> createState() =>
      _ShuttleInfoFABWidgetState();
}

class _ShuttleInfoFABWidgetState extends ConsumerState<ShuttleInfoFABWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 450),
      reverseDuration: const Duration(milliseconds: 175),
      curve: Curves.ease,
      clipBehavior: Clip.none,
      child: FloatingActionButton.extended(
        icon: const Icon(Icons.airport_shuttle),
        label: const Text("Track"),
        isExtended: ref.watch(isFabExtended),
        onPressed: () {
          if (widget.draggableScrollableController.isAttached) {
            double? size;
            if (widget.draggableScrollableController.size > 0) {
              size = 0;
            }
            widget.draggableScrollableController.animateTo(size ?? .25,
                duration: const Duration(milliseconds: 275),
                curve: Curves.ease);
          }
        },
        /*isExtended: widget.draggableScrollableController.isAttached &&
            widget.draggableScrollableController.size == 0,*/
      ),
    );
  }
}
