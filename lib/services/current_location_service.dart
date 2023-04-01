import 'package:flutter/services.dart';
import 'package:location/location.dart';
// import 'package:logger/logger.dart';

// Logger _logger = Logger();

class CurrentLocation {
  Location? location;

  CurrentLocation({required this.location});

  Future<LocationData?> get currentGeoLocation => getCurrentLocation();

  bool? _serviceEnabled;
  PermissionStatus? _permissionStatus;

  Future<bool?> enableService() async {
    // _logger.d("Is service already enabled? : $_serviceEnabled");
    for (int i = 0; i < 3; i++) {
      try {
        _serviceEnabled = await location?.serviceEnabled();
        break;
      } on PlatformException catch (_) {
        await Future.delayed(const Duration(milliseconds: 750));
      }
    }
    return _serviceEnabled == false
        ? location?.requestService()
        : Future(() => _serviceEnabled);
  }

  Future<PermissionStatus?> enablePermission() async {
    _permissionStatus = await location?.hasPermission();
    // _logger.d(
    //     "Does the app has locationPermission? : ${_permissionStatus.toString()}");
    return _permissionStatus == PermissionStatus.denied ||
            _permissionStatus == PermissionStatus.deniedForever
        ? location?.requestPermission()
        : Future(() => _permissionStatus);
  }

  Future<LocationData?> getCurrentLocation() async {
    _serviceEnabled = await enableService();
    // _logger.d("WHat about now? (SERVICE): $_serviceEnabled");
    _permissionStatus = await enablePermission();
    // _logger.d("What about now? (PERMISSON): ${_permissionStatus.toString()}");
    LocationData? locationData;
    if (_serviceEnabled == true &&
        (_permissionStatus == PermissionStatus.granted ||
            _permissionStatus == PermissionStatus.grantedLimited)) {
      // _logger.i("Successfully asking for current location");
      locationData = await location?.getLocation();
    }
    return locationData;
  }
}
