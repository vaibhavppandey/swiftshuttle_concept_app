import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class VITFlutterMapViewWidget extends ConsumerStatefulWidget {
  const VITFlutterMapViewWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      VITFlutterMapViewWidgetState();
}

class VITFlutterMapViewWidgetState
    extends ConsumerState<VITFlutterMapViewWidget> {
  MapController mapController = MapController();

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(12.9692, 79.1559), // VIT VELLORE
        zoom: 17,
        minZoom: 17,
        maxZoom: 19,
        bounds: LatLngBounds(
          LatLng(12.9792, 79.1659),
          LatLng(12.9691, 79.1558),
        ),
        maxBounds: LatLngBounds(
          LatLng(12.9792, 79.1659),
          LatLng(12.9791999, 79.165899),
        ),
        keepAlive: true,
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: "dev.vaibhavppandey.ideathon_concept_app",
        ),
      ],
    );
  }
}
