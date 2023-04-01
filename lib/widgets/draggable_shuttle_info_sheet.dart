import 'package:flutter/material.dart';

import 'package:ideathon_concept_app/models/shuttles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'package:ideathon_concept_app/providers/fab_extended_provider.dart';
import 'package:ideathon_concept_app/providers/location_data_provider.dart';

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
        ref.read(fabExtendedProvider.notifier).collapseFab();
      } else {
        ref.read(fabExtendedProvider.notifier).extendFab();
      }
    });
    AsyncValue<LatLng?> currentLocation = ref.watch(locationDataProvider);
    if (currentLocation.hasValue) {
      widget.draggableScrollableController.animateTo(.25,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutSine);
    }
    return DraggableScrollableSheet(
        initialChildSize: 0,
        minChildSize: 0,
        maxChildSize: .45,
        controller: widget.draggableScrollableController,
        builder: (context, scrollController) {
          return LayoutBuilder(builder: (context, constraints) {
            return Container(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (constraints.maxHeight > 16.0)
                    Container(
                      decoration: ShapeDecoration(
                        color: Theme.of(context).colorScheme.background,
                        shape: const StadiumBorder(),
                      ),
                      height: 4.0,
                      width: 32.0,
                      margin: const EdgeInsets.symmetric(vertical: 6.0),
                    ),
                  Expanded(
                    // height: constraints.maxHeight - 8.0 < 0
                    // ? 0
                    //     : constraints.maxHeight - 8.0,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        clipBehavior: Clip.antiAlias,
                        // itemCount: totalShuttles.length,
                        children: List.generate(
                            totalShuttles.length,
                            (int index) => Card(
                                clipBehavior: Clip.antiAlias,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                elevation: 1,
                                child: InkWell(
                                  splashFactory:
                                      Theme.of(context).splashFactory,
                                  overlayColor: MaterialStateProperty.all(
                                      Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(.12)),
                                  onTap: () {},
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                  totalShuttles[index]
                                                      .putIfAbsent("coverage",
                                                          () => "coverage"),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium),
                                            ],
                                          ),
                                          Text(
                                              totalShuttles[index].putIfAbsent(
                                                  "namePlateId",
                                                  () => "namePlateId"),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withOpacity(.95))),
                                        ],
                                      )),
                                ))),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}
