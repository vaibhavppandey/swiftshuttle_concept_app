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
        zoom: 15,
        minZoom: 15,
        maxZoom: 18,
        bounds: LatLngBounds(
          LatLng(12.9792, 79.1659),
          LatLng(12.9690, 79.1550),
        ),
        maxBounds: LatLngBounds(
          LatLng(13.0800, 79.25),
          LatLng(12.0, 78.5),
        ),
        keepAlive: true,
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: "dev.vaibhavppandey.swiftshuttle_concept",
          subdomains: const <String>['a', 'b', 'c'],
        ),
      ],
    );
  }
}
