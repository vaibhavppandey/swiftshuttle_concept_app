import 'package:flutter/material.dart';

class ShuttleInfoFABWidget extends StatefulWidget {
  const ShuttleInfoFABWidget(
      {required this.draggableScrollableController, super.key});
  final DraggableScrollableController draggableScrollableController;

  @override
  State<ShuttleInfoFABWidget> createState() => _ShuttleInfoFABWidgetState();
}

class _ShuttleInfoFABWidgetState extends State<ShuttleInfoFABWidget> {
  @override
  Widget build(BuildContext context) {
    bool isFabExtended = true;
    widget.draggableScrollableController.addListener(() {
      if (widget.draggableScrollableController.size <= 56) {
        setState(() => isFabExtended = true);
      } else {
        setState(() => isFabExtended = false);
      }
    });
    return FloatingActionButton.extended(
      onPressed: () {
        if (widget.draggableScrollableController.isAttached) {
          widget.draggableScrollableController.animateTo(
              widget.draggableScrollableController.size <= 0 ? 25 / 100 : 0,
              duration: const Duration(milliseconds: 450),
              curve: Curves.ease);
        }
      },
      icon: const Icon(Icons.airport_shuttle),
      label: const Text("Track"),
      isExtended: isFabExtended,
      /*isExtended: widget.draggableScrollableController.isAttached &&
          widget.draggableScrollableController.size == 0,*/
    );
  }
}
