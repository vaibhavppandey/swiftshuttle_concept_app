import 'package:flutter/material.dart';

import 'package:ideathon_concept_app/models/shuttles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateProvider<bool> isFabExtended = StateProvider<bool>((ref) => false);

class DraggableShuttleInfoSheetWidget extends ConsumerStatefulWidget {
  const DraggableShuttleInfoSheetWidget(
      {required this.draggableScrollableController, super.key});

  final DraggableScrollableController draggableScrollableController;

  @override
  ConsumerState<DraggableShuttleInfoSheetWidget> createState() =>
      _DraggableShuttleInfoSheetWidgetState();
}

class _DraggableShuttleInfoSheetWidgetState
    extends ConsumerState<DraggableShuttleInfoSheetWidget> {
  @override
  Widget build(BuildContext context) {
    widget.draggableScrollableController.addListener(() {
      if (widget.draggableScrollableController.size > 0) {
        ref.read(isFabExtended.notifier).state = false;
      } else {
        ref.read(isFabExtended.notifier).state = true;
      }
    });
    return DraggableScrollableSheet(
        initialChildSize: 25 / 100,
        minChildSize: 0,
        maxChildSize: 55 / 100,
        controller: widget.draggableScrollableController,
        builder: (context, scrollController) {
          return Container(
            color: Colors.transparent,
            child: ListView.builder(
              controller: scrollController,
              itemCount: totalShuttles.length,
              itemBuilder: (context, index) {
                Map<String, String> shuttle = totalShuttles[index];
                return Card(
                    shadowColor: Theme.of(context).colorScheme.shadow,
                    elevation: 2,
                    child: ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.directions_bus_rounded),
                        title: Text(
                            shuttle.putIfAbsent("coverage", () => "coverage")),
                        trailing: Text(shuttle.putIfAbsent(
                            "namePlateId", () => "namePlateId"))));
              },
            ),
          );
        });
  }
}
