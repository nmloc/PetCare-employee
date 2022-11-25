import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;
class MapsController extends GetxController {
  Rx<LatLng> center = const LatLng(0, 0).obs;
  late GoogleMapController _controller;
  Rx<Map<MarkerId, Marker>> markers = Rx(<MarkerId, Marker>{});



  Future<void> onMapCreated(GoogleMapController ggMapsController,String pickUpAddress) async {
 _controller = ggMapsController;
    List<geo.Location> locations = await geo.locationFromAddress(pickUpAddress);
    final marker = Marker(
      markerId: const MarkerId('place_name'),
      position: LatLng(locations[0].latitude, locations[0].longitude),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: 'Pick up address',
        snippet: pickUpAddress,
      ),
    );

    markers.value[const MarkerId('place_name')] = marker;
    center.value = LatLng(locations[0].latitude, locations[0].longitude);


    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: center.value, zoom: 15),
      ),
    );
  }
}