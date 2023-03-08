import 'package:location/location.dart';

class CurrentLocation {
  Location? location;

  CurrentLocation({required this.location});

  bool? _serviceEnabled;
  PermissionStatus? _permissionStatus;

  Future<bool?> enableService() async {
    _serviceEnabled = await location?.serviceEnabled();
    return _serviceEnabled == false ? location?.requestService() : null;
  }

  Future<PermissionStatus?> enablePermission() async {
    _permissionStatus = await location?.hasPermission();
    return _permissionStatus == PermissionStatus.denied
        ? location?.requestPermission()
        : null;
  }

  Future<LocationData?> getCurrentLocation() async {
    _serviceEnabled = await enableService();
    _permissionStatus = await enablePermission();
    if (_serviceEnabled != null &&
        _permissionStatus == PermissionStatus.granted) {
      return location?.getLocation();
    }
  }
}
