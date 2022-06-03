import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guided/utils/mixins/global_mixin.dart';
/// App Geolocation services
class GeoLocationServices extends GlobalMixin {
  ///Get coordinates (latitude/longitude)
  Future<Position> getCoordinates() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  ///Display current address using coordinates
  Future<String> getAddressFromCoordinates(double lat, double lng) async {
    final List<Placemark> placeMarks =
    await placemarkFromCoordinates(lat, lng);

    final Placemark placeMark = placeMarks[0];
    final String streetName = captureNullPlaceMarkToString(placeMark.street);
    final String city = captureNullPlaceMarkToString(placeMark.locality);
    final String province =
    captureNullPlaceMarkToString(placeMark.subAdministrativeArea);

    return '$streetName$city$province${placeMark.country}';
  }

  ///Get current location details using coordinates
  Future<Placemark> getCurrentLocationDetails(Position position) async {
    final List<Placemark> placeMarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    return placeMarks[0];
  }
}
