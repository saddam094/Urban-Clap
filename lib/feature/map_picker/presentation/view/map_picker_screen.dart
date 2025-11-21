import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:urban_clap_vendor/res/color/app_color.dart';
import 'package:urban_clap_vendor/res/constant/constant_data.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  GoogleMapController? mapController;
  LatLng? selectedLocation;
  String address = "Move the map to select location";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      selectedLocation = LatLng(position.latitude, position.longitude);
    });

    mapController?.animateCamera(CameraUpdate.newLatLng(selectedLocation!));
    _getAddressFromLatLng(selectedLocation!);
  }

  Future<void> _getAddressFromLatLng(LatLng pos) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(pos.latitude, pos.longitude);
    Placemark place = placemarks.first;

    // setState(() {
    //   address =
    //   "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    // });

    setState(() {
      final parts = [
        place.street,
        place.subLocality,
        place.locality,
        place.administrativeArea,
        place.country
      ];

      // Remove null or empty strings
      address = parts
          .where((e) => e != null && e.trim().isNotEmpty)
          .join(', ');
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      backgroundColor: AppColors.white,
      body: selectedLocation == null
          ? Center(child: CircularProgressIndicator(color: AppColors.primaryColor))
          : Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: Constant.height * .05
            ),
            child: GoogleMap(
              onMapCreated: (controller) => mapController = controller,
              initialCameraPosition:
              CameraPosition(target: selectedLocation!, zoom: 15),
              onCameraMove: (position) {
                selectedLocation = position.target;
              },
              onCameraIdle: () {
                if (selectedLocation != null) {
                  _getAddressFromLatLng(selectedLocation!);
                }
              },
            ),
          ),
          Icon(Icons.location_pin, size: Constant.width * .14, color: AppColors.redColor),

          Positioned(
            bottom: Constant.height * .1,
            left: Constant.width * .03,
            right: Constant.width * .03,
            child: Column(
              children: [
                /// Selected Address ---> Text
                Container(
                  padding: EdgeInsets.all(Constant.width * .03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Constant.width * .03),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          spreadRadius: 2)
                    ],
                  ),
                  child: Text(
                    address,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: Constant.width * .04),
                  ),
                ),

                SizedBox(height: Constant.height * .01),

                /// Confirm Location Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context, {
                      'lat': selectedLocation!.latitude,
                      'lng': selectedLocation!.longitude,
                      'address': address
                    });
                  },
                  icon: const Icon(Icons.check, color: AppColors.redColor,),
                  label: Text("Confirm Location", style: TextStyle(fontSize: Constant.width * .04)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
