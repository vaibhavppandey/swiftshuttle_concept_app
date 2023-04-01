import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:ideathon_concept_app/services/current_location_service.dart';
import 'package:latlong2/latlong.dart';

Location location = Location();
Provider<CurrentLocation> currentLocationProvider =
    Provider((_) => CurrentLocation(location: location));

FutureProvider<LatLng?> locationDataProvider = FutureProvider((ref) async {
  LocationData? locationData = await ref
      .watch(currentLocationProvider)
      .currentGeoLocation
      .timeout(const Duration(seconds: 45));
  LatLng? userLatLng;
  if (locationData != null) {
    userLatLng = LatLng(locationData.latitude!, locationData.longitude!);
  }
  return userLatLng;
});
