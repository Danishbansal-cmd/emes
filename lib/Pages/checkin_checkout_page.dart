import 'package:emes/Pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckinCheckoutPage extends StatefulWidget {
  CheckinCheckoutPage({Key? key}) : super(key: key);

  //initializing values
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(-33.865143, 151.209900), zoom: 11.5, tilt: 40);

  @override
  State<CheckinCheckoutPage> createState() => _CheckinCheckoutPageState();
}

class _CheckinCheckoutPageState extends State<CheckinCheckoutPage> {
  GoogleMapController? _googleMapController;

  final checkinCheckoutController = Get.put(CheckinCheckoutController());

  Marker? _firstMarker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Information"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //upper screen
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [const SizedBox(height: 6,),
                          Details("Client Name",(checkinCheckoutController.details[0])["client_name"]),const SizedBox(height: 6,),
                          Details("Client Id",(checkinCheckoutController.details[0])["client_id"]),const SizedBox(height: 6,),
                          Details("Shift Id",(checkinCheckoutController.details[0])["shift_id"]),const SizedBox(height: 6,),
                          Details("Work Date",(checkinCheckoutController.details[0])["work_date"]),const SizedBox(height: 6,),
                          Details("Time On",(checkinCheckoutController.details[0])["time_on"]),const SizedBox(height: 6,),
                          Details("Time Off",(checkinCheckoutController.details[0])["time_off"]),const SizedBox(height: 6,),
                          Details("Task Id",(checkinCheckoutController.details[0])["task_id"]),const SizedBox(height: 6,),
                          Details("Acitvity Name",(checkinCheckoutController.details[0])["activity_name"]),const SizedBox(height: 6,),
                        ],
                      ),
                    ),
                    Container(
                      height: 250,
                      width: Get.width,
                      // decoration: BoxDecoration(
                      //   color: Colors.red,
                      //   borderRadius: BorderRadius.circular(40),
                      // ),
                      child: GoogleMap(
                        mapType: MapType.satellite,
                        markers: {if (_firstMarker != null) _firstMarker!},
                        initialCameraPosition:
                            CheckinCheckoutPage._initialCameraPosition,
                        zoomControlsEnabled: false,
                        onMapCreated: (controller) =>
                            _googleMapController = controller,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            //bottom checkin and checkout buttons
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Color.fromARGB(255, 255, 129, 46),
                      child: InkWell(
                        onTap: () {},
                        splashColor: Color.fromARGB(255, 158, 74, 17),
                        highlightColor: Colors.amber,
                        child: Container(
                          height: 40,
                          decoration: const BoxDecoration(
                              // color: Color.fromARGB(255, 255, 129, 46),
                              ),
                          child: const Center(
                            child: Text(
                              "CHECK OUT",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      color: Color.fromARGB(255, 117, 37, 192),
                      child: InkWell(
                        onTap: () {
                          checkinCheckoutController.getLocation().then(
                            (value) async {
                              checkinCheckoutController.locationData =
                                  await checkinCheckoutController.location
                                      .getLocation();
                              print(
                                  "valuethen ${checkinCheckoutController.locationData}");
                            },
                          ).then(
                            (value) async {
                              GeoCode geoCode = GeoCode();
                              Address address = await geoCode.reverseGeocoding(
                                  latitude: checkinCheckoutController
                                      .locationData!.latitude!,
                                  longitude: checkinCheckoutController
                                      .locationData!.longitude!);
                              _firstMarker = Marker(
                                markerId: const MarkerId('Your Position'),
                                infoWindow:
                                    const InfoWindow(title: 'Your Position'),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueOrange),
                                position: LatLng(
                                    checkinCheckoutController
                                        .locationData!.latitude!,
                                    checkinCheckoutController
                                        .locationData!.longitude!),
                              );
                              // checkinCheckoutController.updateMap.value = true;
                              _googleMapController!.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                        checkinCheckoutController
                                            .locationData!.latitude!,
                                        checkinCheckoutController
                                            .locationData!.longitude!),
                                    zoom: 15,
                                    tilt: 40,
                                  ),
                                ),
                              );
                              setState(() {});
                            },
                          );
                        },
                        splashColor: Color.fromARGB(255, 76, 23, 126),
                        highlightColor: Colors.amber,
                        child: Container(
                          height: 40,
                          decoration: const BoxDecoration(
                              // color: Color.fromARGB(255, 117, 37, 192),
                              ),
                          child: const Center(
                            child: Text(
                              "CHECK IN",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Details(String value,String value2) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value,style: Theme.of(context).textTheme.headline5,),
          Text(value2),
        ],
      ),
    );
  }
}

class CheckinCheckoutController extends GetxController {
  LocationData? locationData;
  var location = new Location();
  bool? serviceEnabled;
  PermissionStatus? _permissionGranted;
  var details = Get.arguments;

  Future getLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled!) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled!) {
        return null;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.grantedLimited) {
        // locationData = await location.getLocation();
        return null;
      }
    }
    // print("i am called");
    // print("print location $location");
    // locationData = await location.getLocation();
    // print("locationData from checkin ${locationData}");
    // return locationData!;
  }

  //update markers with the getx
  // RxBool updateMap = false.obs;
}
