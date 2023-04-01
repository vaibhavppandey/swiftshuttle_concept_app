import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:ideathon_concept_app/providers/location_data_provider.dart'
    show locationDataProvider;

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
    AsyncValue<LatLng?> currentLocation = ref.watch(locationDataProvider);
    return currentLocation.when(
      error: (error, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.nearby_error_rounded,
            color: Theme.of(context).colorScheme.error,
            size: 48,
          ),
          Text(
            "Couldn't get your current location",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 4.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              error.toString(),
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      loading: () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox.square(
            dimension: 48.0,
            child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary),
          ),
          Text("Getting your current location",
              style: Theme.of(context).textTheme.titleLarge)
        ],
      ),
      data: (LatLng? userLatLng) => FlutterMap(
        options: MapOptions(
          center: userLatLng, // VIT VELLORE
          zoom: 18,
          minZoom: 16,
          maxZoom: 18,
          // bounds: LatLngBounds(
          //   LatLng(12.9792, 79.1659),
          //   LatLng(12.9692, 79.1559),

          maxBounds: LatLngBounds(
            LatLng(12.967026, 79.153576),
            LatLng(12.977649, 79.168510),
          ),
          interactiveFlags: InteractiveFlag.all, // & ~InteractiveFlag.rotate,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: "dev.vaibhavppandey.ideathon_concept_app",
          ),
          MarkerLayer(
            markers: <Marker>[
              Marker(
                  point: userLatLng ?? LatLng(12.9792, 79.1659),
                  rotate: true,
                  builder: (context) => Icon(Icons.person_pin_circle_rounded,
                      size: 32,
                      color: Theme.of(context).colorScheme.primaryContainer))
            ],
          )
        ],
      ),
    );
  }
}
