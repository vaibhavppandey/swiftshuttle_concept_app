import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ideathon_concept_app/widgets/vit_fluttermap.dart';
import 'package:ideathon_concept_app/widgets/draggable_shuttle_info_sheet.dart';
import 'package:ideathon_concept_app/widgets/shuttleinfo_fab.dart';

class ShuttlePathMapViewConsumerScreen extends ConsumerStatefulWidget {
  const ShuttlePathMapViewConsumerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShuttlePathMapViewConsumerScreenState();
}

class _ShuttlePathMapViewConsumerScreenState
    extends ConsumerState<ShuttlePathMapViewConsumerScreen> {
  DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  @override
  void dispose() {
    draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Material(
            shape: const CircleBorder(),
            type: MaterialType.button,
            color: Theme.of(context).colorScheme.surface.withOpacity(.75),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {},
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(clipBehavior: Clip.antiAlias, children: [
        LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: const VITFlutterMapViewWidget(),
          ),
        ),
        DraggableShuttleInfoSheetWidget(
          draggableScrollableController: draggableScrollableController,
        ),
      ]),
      floatingActionButton: ShuttleInfoFABWidget(
        draggableScrollableController: draggableScrollableController,
      ),
    );
  }
}
