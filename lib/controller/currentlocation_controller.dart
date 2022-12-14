
import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CurrentLocationController extends GetxController {
  var latitude='Getting Latitude...'.obs;
var longitude='Getting Longitude...'.obs;
var address='Getting Address...'.obs;
late StreamSubscription<Position>streamSubscription;

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }
  
getLocation()async{
  bool serviceEnabled;
  LocationPermission permission;
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
streamSubscription=Geolocator.getPositionStream().listen((Position position) {
  latitude.value='Latitude : ${position.latitude}';
  longitude.value='Longitude : ${position.longitude}';
  getAddresFromLatLang(position);
 });
}

Future<void>getAddresFromLatLang(Position position)async{
  List<Placemark>placemark=await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark place=placemark[0];
  address.value='Address : ${place.locality},${place.country}';
}
}

