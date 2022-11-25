import 'package:dogs_park/controllers/controller.dart';
import 'package:dogs_park/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Maps extends StatefulWidget {
  final String pickUpAddress;

  const Maps({Key? key, required this.pickUpAddress}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final mapsController = Get.put(MapsController());
  @override
  void dispose() {
    super.dispose();
  }
  // LatLng _center = const LatLng(0, 0);
  // late GoogleMapController _controller;
  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  //
  // Future<void> _onMapCreated(GoogleMapController _cntlr) async {
  //   _controller = _cntlr;
  //
  //   List<geo.Location> locations = await geo.locationFromAddress(widget.pickUpAddress);
  //   final marker = Marker(
  //     markerId: const MarkerId('place_name'),
  //     position: LatLng(locations[0].latitude, locations[0].longitude),
  //     icon: BitmapDescriptor.defaultMarker,
  //     infoWindow: InfoWindow(
  //       title: 'Pick up address',
  //       snippet: widget.pickUpAddress,
  //     ),
  //   );
  //   setState(() {
  //     markers[const MarkerId('place_name')] = marker;
  //     _center = LatLng(locations[0].latitude, locations[0].longitude);
  //   });
  //
  //   _controller.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(target: _center, zoom: 15),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double maxHeight =MediaQuery.of(context).size.height;
    double maxWidth =MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.whiteColor,
            leading: IconButton(
              onPressed: () {
              Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new,color: ColorResources.blackColor,),
            ),
            title: const Text("Location pick up"),centerTitle: true,),
        body: Center(
          child: SizedBox(
            height: maxHeight,
            width: maxWidth,
            child: Stack(
              children: [
                Obx(()=>
                   GoogleMap(
                    markers: mapsController.markers.value.values.toSet(),
                    initialCameraPosition: CameraPosition(target: mapsController.center.value),
                    mapType: MapType.normal,
                    onMapCreated: (controller) => mapsController.onMapCreated(controller,widget.pickUpAddress),
                    myLocationEnabled: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
