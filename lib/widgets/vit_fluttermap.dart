import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import 'package:ideathon_concept_app/services/current_location_service.dart';

CurrentLocation currentLocation = CurrentLocation(location: Location());

FutureProvider<LatLng> locationDataProvider = FutureProvider((ref) async {
  LocationData? locationData = await currentLocation.getCurrentLocation();
  return LatLng(locationData?.latitude ?? 12.971127,
      locationData?.longitude ?? 79.163846);
});

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<LatLng> currentLocation = ref.watch(locationDataProvider);
    return FlutterMap(
      options: MapOptions(
        center: LatLng(12.971127, 79.163846), // VIT VELLORE
        zoom: 18,
        minZoom: 16,
        maxZoom: 18,
        // bounds: LatLngBounds(
        //   LatLng(12.9792, 79.1659),
        //   LatLng(12.9692, 79.1559),
        // ),
        maxBounds: LatLngBounds(
          LatLng(12.967026, 79.153576),
          LatLng(12.977649, 79.168510),
        ),
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(source: "© OpenStreetMap contributors"),
        AttributionWidget.defaultWidget(source: "© FlutterMap contributors"),
      ],
      children: [
        MarkerLayer(
          markers: [
            Marker(
                width: 32,
                height: 32,
                point: currentLocation.value ?? LatLng(12.971127, 79.163846),
                rotate: false,
                builder: (context) => Icon(Icons.person_pin_circle_rounded,
                    color: Theme.of(context).colorScheme.primary))
          ],
        ),
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: "dev.vaibhavppandey.ideathon_concept_app",
        ),
      ],
    );
  }
}
