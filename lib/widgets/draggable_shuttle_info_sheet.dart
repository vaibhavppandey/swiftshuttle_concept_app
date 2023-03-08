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
        initialChildSize: .25,
        minChildSize: 0,
        maxChildSize: .55,
        controller: widget.draggableScrollableController,
        builder: (context, scrollController) {
          return Container(
            color: Colors.transparent,
            child: ListView.custom(
              controller: scrollController,
              physics: const ClampingScrollPhysics(),
              clipBehavior: Clip.antiAlias,
              // itemCount: totalShuttles.length,
              childrenDelegate: SliverChildBuilderDelegate(
                  childCount: totalShuttles.length, (context, index) {
                Map<String, String> shuttle = totalShuttles[index];
                return Card(
                    shadowColor: Theme.of(context).colorScheme.shadow,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    elevation: 6,
                    child: InkWell(
                      splashFactory: Theme.of(context).splashFactory,
                      splashColor: Theme.of(context).splashColor,
                      overlayColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primary),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.directions_bus_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.30),
                                  ),
                                  const SizedBox(
                                    width: 32,
                                  ),
                                  Text(
                                      shuttle.putIfAbsent(
                                          "coverage", () => "coverage"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                              Text(
                                  shuttle.putIfAbsent(
                                      "namePlateId", () => "namePlateId"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(.95))),
                            ],
                          )),
                    ));
              }),
            ),
          );
        });
  }
}
