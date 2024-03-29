import 'dart:convert';
import 'dart:math';
import 'package:emes/Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:emes/Pages/home_page.dart';
import 'package:flutter/material.dart';
// import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
// import 'package:geocoder/geocoder.dart';
import 'package:geocoder2/geocoder2.dart';
// import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
import 'package:flutter_html/flutter_html.dart';

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
  Marker? _justMarker;

  //initializing initState method
  @override
  void initState() {
    super.initState();

    getUniformInformation();
  }

  //to get related information about uniform
  //whether it is required or not
  Future<void> getUniformInformation() async {
    checkinCheckoutController.uniformAndOtherData.value =
        await checkinCheckoutController.getUniformInformation(
            (checkinCheckoutController.details[0])["client_id"]);
    print(
        "this is the initsate ${checkinCheckoutController.uniformAndOtherData.value}");
  }

  bool isUniformDataAvailable = false;

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Details(
                            "Client Name",
                            (checkinCheckoutController
                                .details[0])["client_name"]),
                        Details(
                            "Client Id",
                            (checkinCheckoutController
                                .details[0])["client_id"]),
                        Details("Shift Id",
                            (checkinCheckoutController.details[0])["shift_id"]),
                        Details(
                            "Work Date",
                            (checkinCheckoutController
                                .details[0])["work_date"]),
                        Details("Time On",
                            (checkinCheckoutController.details[0])["time_on"]),
                        Details("Time Off",
                            (checkinCheckoutController.details[0])["time_off"]),
                        Details("Task Id",
                            (checkinCheckoutController.details[0])["task_id"]),
                        Details(
                            "Acitvity Name",
                            (checkinCheckoutController
                                .details[0])["activity_name"]),
                        //to show Venue Information data
                        Obx(
                          () => checkinCheckoutController
                                  .uniformAndOtherData.isNotEmpty
                              ? Column(
                                  children: [
                                    //to show (manager_to_report and supervisor_to_report) data
                                    Details(
                                        "Manager To Report",
                                        (checkinCheckoutController
                                                    .uniformAndOtherData[4] ==
                                                "")
                                            ? "No Manager"
                                            : checkinCheckoutController
                                                .uniformAndOtherData[4]),
                                    Details(
                                        "Supervisor To Report",
                                        (checkinCheckoutController
                                                    .uniformAndOtherData[5] ==
                                                "")
                                            ? "No Supervisor"
                                            : checkinCheckoutController
                                                .uniformAndOtherData[5]),
                                    Details(
                                      "State",
                                      checkinCheckoutController
                                          .uniformAndOtherData[0],
                                    ),
                                    Details(
                                      "Suburb",
                                      checkinCheckoutController
                                          .uniformAndOtherData[1],
                                    ),
                                    Details(
                                      "Street",
                                      checkinCheckoutController
                                          .uniformAndOtherData[2],
                                    ),
                                    Details(
                                      "Postcode",
                                      checkinCheckoutController
                                          .uniformAndOtherData[3],
                                    ),
                                    //for uniform information data
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 24.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: Offset(5.0, 5.0),
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Uniform \nInformation",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                  fontFamily: 'Ubuntu-Regular',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Html(
                                              data: checkinCheckoutController
                                                              .uniformAndOtherData[
                                                          6] ==
                                                      "1"
                                                  ? checkinCheckoutController
                                                      .uniformAndOtherData[7]
                                                  : 'No Uniform Required',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                        ),
                      ],
                    ),
                    //to show checkin and checkout time containers
                    Column(
                      children: [
                        //for checkin time
                        Obx(
                          () => Visibility(
                            visible: checkinCheckoutController
                                .showCheckInTimeContainer.value,
                            child: Details("CheckIn Time:",
                                checkinCheckoutController.checkInTime.value),
                          ),
                        ),
                        //for checkout time
                        Obx(
                          () => Visibility(
                            visible: checkinCheckoutController
                                .showCheckOutTimeContainer.value,
                            child: Details("CheckOut Time:",
                                checkinCheckoutController.checkOutTime.value),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //fixed google map
            //under the bottom of the screen
            Obx(
              () => Visibility(
                visible:
                    !(checkinCheckoutController.checkInTime.value.isNotEmpty &&
                        checkinCheckoutController.checkOutTime.value.isNotEmpty),
                child: Column(
                  children: [
                    //will visible when map will get your location
                    //after clicking checkin
                    Obx(
                      () => Visibility(
                        visible:
                            checkinCheckoutController.showAddressLocation.value,
                        child: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Material(
                                color: Color.fromARGB(255, 218, 218, 218),
                                child: InkWell(
                                  onTap: () {
                                    Future.delayed(
                                        const Duration(milliseconds: 200), () {
                                      checkinCheckoutController
                                          .showAddressLocation.value = false;
                                      checkinCheckoutController
                                          .showCheckInTimeContainer
                                          .value = true;
                                      checkinCheckoutController
                                              .checkInTime.value =
                                          DateTime.now()
                                              .toString()
                                              .substring(0, 16);
                                      Get.snackbar("Great! Location confirmed!",
                                          "Shift Confirmed and timer starts.",
                                          duration: const Duration(
                                              milliseconds: 1700));
                                    });
                                  },
                                  splashColor: Colors.blue,
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        // color: Color.fromARGB(255, 218, 218, 218),
                                        ),
                                    width: 120,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: const Center(
                                      child: Text(
                                        "        Confirm \nYour Location:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    checkinCheckoutController
                                        .addressLocation.value,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //to show google map
                    //on the bottom of screen
                    Stack(
                      children: [
                        //stacks first child
                        Container(
                          height: 250,
                          width: Get.width,
                          // decoration: BoxDecoration(
                          //   color: Colors.red,
                          //   borderRadius: BorderRadius.circular(40),
                          // ),
                          child: GoogleMap(
                            mapType: MapType.normal,
                            markers: {
                              if (_firstMarker != null) _firstMarker!,
                              if (_justMarker != null) _justMarker!,
                            },
                            //to get lat lng of some place
                            onLongPress: addMarker,
                            initialCameraPosition:
                                CheckinCheckoutPage._initialCameraPosition,
                            zoomControlsEnabled: false,
                            onMapCreated: (controller) =>
                                _googleMapController = controller,
                          ),
                        ),
                        //stacks second child
                        //to show CircularProgressIndicator on map after
                        //clikcing checkin button
                        Obx(
                          () => Visibility(
                            visible: checkinCheckoutController
                                .showCircularProgressIndicator.value,
                            child: Container(
                              height: 250,
                              width: Get.width,
                              color: Color.fromARGB(89, 223, 223, 223),
                              // color: Colors.red,
                              // decoration: BoxDecoration(
                              //   color: Colors.red,
                              //   borderRadius: BorderRadius.circular(40),
                              // ),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //
            //copied
            //bottom checkin and checkout buttons
            Obx(
              () => Visibility(
                visible: checkinCheckoutController
                    .checkinCheckoutButtonVisibility.value,
                child: Material(
                  color: checkinCheckoutController
                              .checkinCheckoutButtonText.value ==
                          "CHECK IN"
                      ? Color.fromARGB(255, 31, 224, 37)
                      : Color.fromARGB(255, 252, 39, 24),
                  child: InkWell(
                    onTap: () async {
                      //
                      //if button value is CHECK IN
                      if (checkinCheckoutController
                              .checkinCheckoutButtonText.value ==
                          "CHECK IN") {
                        //to showCircularProgressIndicator
                        checkinCheckoutController
                            .showCircularProgressIndicator.value = true;
                        //getting latlong of the venueplace or clientid
                        List<String> venueLatLong =
                            await checkinCheckoutController.getLatLong(
                                (checkinCheckoutController
                                    .details[0])["client_id"]);
                        //to get the current time when user click on check in
                        var date = DateTime.now();
                        //to check if user try to check in only 15 minutes before the
                        //actual time
                        // if (DateTime.now().isAfter(DateTime.parse(
                        //             '${checkinCheckoutController.details[0]['work_date']}T${checkinCheckoutController.details[0]['time_on']}')
                        //         .subtract(const Duration(minutes: 15))) &&
                        //     DateTime.now().isBefore(DateTime.parse(
                        //             '${checkinCheckoutController.details[0]['work_date']}T${checkinCheckoutController.details[0]['time_off']}')
                        //         .add(const Duration(minutes: 15)))) {
                        if (true) {
                          checkinCheckoutController.getLocation().then(
                            (value) async {
                              checkinCheckoutController.locationData =
                                  await checkinCheckoutController.location
                                      .getLocation();
                              print(
                                  "valuethen ${checkinCheckoutController.locationData}");
                            },
                          ).then((value) async {
                            //checking user latlong with accordance to the
                            //shift place
                            //to get the straight distance between user
                            //and its shift place
                            print("venue lat long ${venueLatLong}");
                            //if venueLatLong or venueLocation is not empty
                            if (venueLatLong.isNotEmpty) {
                              if (venueLatLong[0].isNotEmpty ||
                                  venueLatLong[1].isNotEmpty) {
                                print("haha ${double.parse(venueLatLong[0])}");
                                print("haha ${double.parse(venueLatLong[1])}");
                                print(
                                    "haha2 ${checkinCheckoutController.locationData!.latitude!}");
                                print(
                                    "haha2 ${checkinCheckoutController.locationData!.longitude!}");
                                var userDistanceFromShiftPlace =
                                    checkinCheckoutController.calculateDistane([
                                  //latlong of user position
                                  LatLng(
                                    checkinCheckoutController
                                        .locationData!.latitude!,
                                    checkinCheckoutController
                                        .locationData!.longitude!,
                                  ),
                                  // //bathinda lat long
                                  // const LatLng(
                                  //   30.210995,
                                  //   74.945473,
                                  // )
                                  //latlong of the venueplace or clientid

                                  LatLng(double.parse(venueLatLong[0]),
                                      double.parse(venueLatLong[1]))
                                ]);
                                // if (userDistanceFromShiftPlace > 150) {
                                if (false) {
                                  checkinCheckoutController
                                      .showCircularProgressIndicator
                                      .value = false;

                                  //if user is too away from shift

                                  Get.snackbar(
                                    'Message',
                                    'You must be within the range of 150 Meters, You are too away from the shift place.',
                                  );
                                  Future.delayed(
                                      const Duration(milliseconds: 30), () {
                                    Get.snackbar('Message',
                                        "You are ${userDistanceFromShiftPlace.round()} meters away from the shift place.");
                                  });
                                } else {
                                  print("i am here");
                                  //if user is in the right place and right time
                                  //from geocoding
                                  List<geocoding.Placemark> placemarks =
                                      await geocoding.placemarkFromCoordinates(
                                          checkinCheckoutController
                                              .locationData!.latitude!,
                                          checkinCheckoutController
                                              .locationData!.longitude!);
                                  print("placemarks $placemarks");
                                  geocoding.Placemark place = placemarks[0];
                                  print("place ${place}");
                                  print("placemarks ${place.street}");
                                  checkinCheckoutController
                                          .addressLocation.value =
                                      '${place.street} ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.administrativeArea}, ${place.country}';
                                  print(
                                      "this is the geocoding address ${checkinCheckoutController.addressLocation.value}");
                                  // setState(() {});
                                  //from geocode
                                  // GeoCode geoCode = GeoCode();
                                  // Address address =
                                  //     await geoCode.reverseGeocoding(
                                  //         latitude:
                                  //             checkinCheckoutController
                                  //                 .locationData!.latitude!,
                                  //         longitude:
                                  //             checkinCheckoutController
                                  //                 .locationData!
                                  //                 .longitude!);
                                  // checkinCheckoutController
                                  //         .addressLocation.value =
                                  //     "${address.countryName}(${address.countryCode}) ${address.region}(${address.postal}) ${address.streetAddress} ${address.streetNumber}";
                                  //to get user location address
                                  //from geocoder
                                  // var address = await Geocoder.local
                                  //     .findAddressesFromCoordinates(Coordinates(
                                  // checkinCheckoutController
                                  //     .locationData!.latitude!,
                                  // checkinCheckoutController
                                  //     .locationData!.longitude!));
                                  // Address newAddress;
                                  // newAddress = address.first;
                                  // checkinCheckoutController.addressLocation
                                  //     .value = newAddress.addressLine;
                                  // print("geocoder adresses ${address.first}");
                                  // print(
                                  //     "geocoder adresses ${newAddress.addressLine}");
                                  //from geocoder2
                                  // GeoData data =
                                  //     await Geocoder2.getDataFromCoordinates(
                                  //         latitude:
                                  //             checkinCheckoutController
                                  //                 .locationData!.latitude!,
                                  //         longitude: checkinCheckoutController
                                  //             .locationData!.longitude!,
                                  //         googleMapApiKey:
                                  //             "AIzaSyBE4FuOoF0qPuxlXyJeAiVThIMDX0iwx2I");
                                  // checkinCheckoutController
                                  //         .addressLocation.value =
                                  //     data.country +
                                  //         " " +
                                  //         data.state +
                                  //         " " +
                                  //         data.city +
                                  //         " " +
                                  //         data.postalCode +
                                  //         " " +
                                  //         data.address;
                                  // print(
                                  //     "this is the geocoder2 address ${data.country + " " + data.state + " " + data.city + " " + data.postalCode + " " + data.address}");
                                  //resume previous function
                                  checkinCheckoutController
                                      .showAddressLocation.value = true;
                                  checkinCheckoutController
                                      .showCircularProgressIndicator
                                      .value = false;
                                  //to add marker
                                  _firstMarker = Marker(
                                    markerId: const MarkerId('Your Position'),
                                    infoWindow: const InfoWindow(
                                        title: 'Your Position'),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueOrange),
                                    position: LatLng(
                                        checkinCheckoutController
                                            .locationData!.latitude!,
                                        checkinCheckoutController
                                            .locationData!.longitude!),
                                  );
                                  //function to checked the user in database
                                  checkinCheckoutController.checkinUser(
                                      checkinCheckoutController.details[0]
                                          ['shift_id'],
                                      (checkinCheckoutController
                                              .locationData!.latitude!)
                                          .toString(),
                                      (checkinCheckoutController
                                              .locationData!.longitude!)
                                          .toString());

                                  //updating cameraPosition
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
                                }
                              } else {
                                // venueLatLng is not empty
                                //but it holds empty string
                                checkinCheckoutController
                                    .showCircularProgressIndicator
                                    .value = false;
                                Get.snackbar('Message',
                                    'Place does not exist in the backend.');
                              }
                            } else {
                              // if venue location is empty
                              checkinCheckoutController
                                  .showCircularProgressIndicator.value = false;
                              Get.snackbar(
                                  'Message', 'Shift Place does not exist.',
                                  duration: const Duration(milliseconds: 1700));
                            }
                          });
                        } else {
                          checkinCheckoutController
                              .showCircularProgressIndicator.value = false;
                          Get.snackbar("Not Allowed.",
                              "Check In option is allowed only 15 minutes before scheduled time of shift.",
                              duration: const Duration(milliseconds: 1200));
                        }
                      } //
                      //if button value is CHECK OUT
                      else if (checkinCheckoutController
                              .checkinCheckoutButtonText.value ==
                          "CHECK OUT") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 12,
                                    ).copyWith(bottom: 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Confirm",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                fontSize: 18,
                                              ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                            "Are you sure you want to checkout?"),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  splashColor:
                                                      const Color.fromARGB(
                                                          255, 30, 89, 137),
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12,
                                                        horizontal: 20),
                                                    child: const Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              64,
                                                              160,
                                                              239)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  splashColor: Color.fromARGB(
                                                      255, 159, 40, 34),
                                                  onTap: () {
                                                    // checkinCheckoutController
                                                    //         .checkOutTime
                                                    //         .value =
                                                    //     DateTime.now()
                                                    //         .toString()
                                                    //         .substring(0, 16);
                                                    // checkinCheckoutController
                                                    //     .showCheckOutTimeContainer
                                                    //     .value = true;
                                                    print("checkingout");
                                                    print(
                                                        checkinCheckoutController
                                                                .details[0]
                                                            ['shift_id']);
                                                    // print(
                                                    //     (checkinCheckoutController
                                                    //             .locationData!
                                                    //             .latitude)
                                                    //         .toString());
                                                    // print(
                                                    //     (checkinCheckoutController
                                                    //             .locationData!
                                                    //             .longitude)
                                                    //         .toString());

                                                    //to checkout the user into database

                                                    //
                                                    //firstly need to get the user location on
                                                    //checking out
                                                    checkinCheckoutController
                                                        .getLocation()
                                                        .then(
                                                      (value) async {
                                                        checkinCheckoutController
                                                                .locationData =
                                                            await checkinCheckoutController
                                                                .location
                                                                .getLocation();
                                                        print(
                                                            "valuethen ${checkinCheckoutController.locationData}");
                                                      },
                                                    ).then((value) {
                                                      checkinCheckoutController.checkoutUser(
                                                          checkinCheckoutController
                                                                  .details[0]
                                                              ['shift_id'],
                                                          (checkinCheckoutController
                                                                  .locationData!
                                                                  .latitude)
                                                              .toString(),
                                                          (checkinCheckoutController
                                                                  .locationData!
                                                                  .longitude)
                                                              .toString());
                                                    });

                                                    checkinCheckoutController
                                                        .checkinCheckoutButtonVisibility
                                                        .value = false;
                                                    checkinCheckoutController
                                                        .getCheckinCheckout(
                                                            checkinCheckoutController
                                                                    .details[0]
                                                                ['shift_id']);
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12,
                                                        horizontal: 20),
                                                    child: const Text(
                                                      "Confirm",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 230, 64, 55),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    splashColor: checkinCheckoutController
                                .checkinCheckoutButtonText.value ==
                            "CHECK IN"
                        ? Color.fromARGB(255, 27, 126, 30)
                        : Color.fromARGB(255, 126, 19, 19),
                    highlightColor: Colors.amber,
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                          // color: Color.fromARGB(255, 255, 129, 46),
                          ),
                      child: Center(
                        child: Obx(
                          () => Text(
                            checkinCheckoutController
                                .checkinCheckoutButtonText.value,
                            style: const TextStyle(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Details(String value, String value2) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 24.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(5.0, 5.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontFamily: 'Ubuntu-Regular',
                  fontWeight: FontWeight.w400,
                ),
          ),
          Text(value2),
        ],
      ),
    );
  }

  // to get lat lng of some place
  addMarker(LatLng pos) {
    setState(() {
      _justMarker = Marker(
        markerId: const MarkerId('just marker'),
        infoWindow: const InfoWindow(title: 'Your Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
      print("pos of just marker ${pos}");
    });
  }
}

class CheckinCheckoutController extends GetxController {
  LocationData? locationData;
  var location = new Location();
  bool? serviceEnabled;
  PermissionStatus? _permissionGranted;
  var details = Get.arguments;
  RxList<String> uniformAndOtherData = <String>[].obs;

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
        return Future.error('Location permissions are denied');
      }
    }

    if (_permissionGranted == PermissionStatus.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // print("i am called");
    // print("print location $location");
    // locationData = await location.getLocation();
    // print("locationData from checkin ${locationData}");
    // return locationData!;
  }

  //update markers with the getx
  // RxBool updateMap = false.obs;

  //update location name
  RxString addressLocation = "".obs;

  //update addresslocationbool
  RxBool showAddressLocation = false.obs;

  //showing circularprogressindicator on clicking checkin
  RxBool showCircularProgressIndicator = false.obs;

  //showing checkin time container bool
  RxBool showCheckInTimeContainer = false.obs;
  RxString checkInTime = "".obs;

  //showing checkout time container bool
  RxBool showCheckOutTimeContainer = false.obs;
  RxString checkOutTime = "".obs;

  //some function to get the stratight distance between points
  double calculateDistane(List<LatLng> polyline) {
    double totalDistance = 0;
    for (int i = 0; i < polyline.length; i++) {
      if (i < polyline.length - 1) {
        // skip the last index
        totalDistance += getStraightLineDistance(
            polyline[i + 1].latitude,
            polyline[i + 1].longitude,
            polyline[i].latitude,
            polyline[i].longitude);
      }
    }
    return totalDistance;
  }

  double getStraightLineDistance(lat1, lon1, lat2, lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1);
    var dLon = deg2rad(lon2 - lon1);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c; // Distance in km
    return d * 1000; //in m
    // return d; //in km
  }

  dynamic deg2rad(deg) {
    return deg * (pi / 180);
  }

  //to get the latlong of the venueplace or clientid
  Future<List<String>> getLatLong(String clientid) async {
    http.Response response;
    // ignore: prefer_typing_uninitialized_variables
    var jsonData;
    response = await http.post(Uri.parse(
        Constants.getCompanyURL + '/api/get_venue/' + clientid));

    jsonData = jsonDecode(response.body);
    print(jsonData.runtimeType);
    print((jsonData['status']).runtimeType);
    // print('adfs');
    // print(jsonData);

    if (jsonData['status'] == 200) {
      print("messsage ${jsonData['message']}");
      return [
        jsonData['data']['Client']['loc_lat'],
        jsonData['data']['Client']['loc_long']
      ];
    }

    return [];
  }

  //to get the uniform related information of the venueplace
  Future<List<String>> getUniformInformation(String clientid) async {
    http.Response response;
    // ignore: prefer_typing_uninitialized_variables
    var jsonData;
    response = await http.post(Uri.parse(
        Constants.getCompanyURL + '/api/get_venue/' + clientid));

    jsonData = jsonDecode(response.body);
    print(jsonData.runtimeType);
    print((jsonData['status']).runtimeType);
    // print('adfs');
    // print(jsonData);

    if (jsonData['status'] == 200) {
      print("messsage ${jsonData['message']}");
      print(
          "data ${jsonData['data']['ClientInformation']['uniform_description']}");

      return [
        jsonData['data']['ClientInformation']['state'],
        jsonData['data']['ClientInformation']['suburb'],
        jsonData['data']['ClientInformation']['street'],
        jsonData['data']['ClientInformation']['postcode'],
        jsonData['data']['ClientInformation']['manager_to_report'],
        jsonData['data']['ClientInformation']['supervisor_to_report'],
        jsonData['data']['ClientInformation']['uniform_required'],
        jsonData['data']['ClientInformation']['uniform_description']
      ];
    }

    return [];
  }

  //to get checkincheckout time from database
  Future getCheckinCheckout(String userAllowShiftId) async {
    print("userAllowShiftId $userAllowShiftId");
    print('i here 4');
    http.Response response;
    // ignore: prefer_typing_uninitialized_variables
    var jsonData;
    response = await http.post(
        Uri.parse(Constants.getCompanyURL + '/api/checkinoutTime'),
        body: {
          'user_id': Constants.getStaffID,
          'user_allow_shift_id': userAllowShiftId,
        });

    jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 200) {
      print('i here 5');
      print("messsage ${jsonData['message']}");
      if (jsonData['data']['check_in'] != "00:00:00") {
        showCheckInTimeContainer.value = true;
        checkInTime.value = jsonData['data']['check_in'];
        checkinCheckoutButtonText.value = "CHECK OUT";
        checkinCheckoutButtonVisibility.value = true;
        print('i here 6');
      }
      if (jsonData['data']['check_out'] != "00:00:00") {
        showCheckOutTimeContainer.value = true;
        checkOutTime.value = jsonData['data']['check_out'];
        checkinCheckoutButtonVisibility.value = false;
        print("i here");
      }
      // if(jsonData['data']['check_in'] != "00:00:00" && jsonData['data']['check_out'] != "00:00:00"){
      //   checkinCheckoutButtonVisibility.value = false;
      //   print("i here2");
      // }
      if (jsonData['data']['check_in'] == "00:00:00" &&
          jsonData['data']['check_out'] == "00:00:00") {
        checkinCheckoutButtonText.value = "CHECK IN";
        checkinCheckoutButtonVisibility.value = true;
      }
    }
  }

  //to checkin the user into database
  Future checkinUser(
      String userAllowShiftId, String checkinlat, String checkinlong) async {
    http.Response response;
    // ignore: prefer_typing_uninitialized_variables
    response = await http.post(
        Uri.parse(Constants.getCompanyURL + '/api/checkin'),
        body: {
          'user_id': Constants.getStaffID,
          'user_allow_shift_id': userAllowShiftId,
          'check_in_lat': checkinlat,
          'check_in_long': checkinlong
        });
    print("response.body ${response.body}");
    getCheckinCheckout(userAllowShiftId);
  }

  //to checkout the user into database
  Future checkoutUser(
      String userAllowShiftId, String checkoutlat, String checkoutlong) async {
    print("checkout here bro");
    http.Response response;
    // ignore: prefer_typing_uninitialized_variables
    response = await http.post(
        Uri.parse(Constants.getCompanyURL + '/api/checkout'),
        body: {
          'user_id': Constants.getStaffID,
          'user_allow_shift_id': userAllowShiftId,
          'check_in_lat': checkoutlat,
          'check_in_long': checkoutlong
        });
    print("response.body ${response.body}");
    getCheckinCheckout(userAllowShiftId);
  }

  //
  //
  //copied testing
  RxBool checkinCheckoutButtonVisibility = false.obs;
  RxString checkinCheckoutButtonText = "CHECK IN".obs;

  //onit function
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCheckinCheckout(Get.arguments[0]['shift_id']);
    print('i here 3');
  }
}
