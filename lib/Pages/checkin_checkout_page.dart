import 'dart:convert';
import 'dart:math';
import 'package:emes/Utils/configure_platform.dart';
import 'package:emes/Utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:flutter_html/flutter_html.dart';

class CheckinCheckoutPage extends StatefulWidget {
  String? shiftId;
  String? clientId;
  String? workDate;
  String? timeOn;
  String? timeOff;
  String? taskId;
  String? clientName;
  String? activityName;
  String? dayOfShift;
  CheckinCheckoutPage(
      {Key? key,
      this.shiftId,
      this.clientId,
      this.activityName,
      this.clientName,
      this.dayOfShift,
      this.taskId,
      this.timeOff,
      this.timeOn,
      this.workDate})
      : super(key: key);

  //initializing values
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(-33.865143, 151.209900), zoom: 11.5, tilt: 40);

  @override
  State<CheckinCheckoutPage> createState() => _CheckinCheckoutPageState();
}

class _CheckinCheckoutPageState extends State<CheckinCheckoutPage> {
  GoogleMapController? _googleMapController;

  final checkinCheckoutController = Get.put(CheckinCheckoutController());
  ConfigurePlatform _configurePlatform = ConfigurePlatform();

  Marker? _firstMarker;
  Marker? _justMarker;

  //initializing initState method
  @override
  void initState() {
    super.initState();

    getUniformInformation();
    checkinCheckoutController.getCheckinCheckout(widget.shiftId!);
  }

  //to get related information about uniform
  //whether it is required or not
  Future<void> getUniformInformation() async {
    checkinCheckoutController.uniformAndOtherData.value =
        await checkinCheckoutController.getUniformInformation(widget.clientId!);
    // print(
    //     "this is the initsate ${checkinCheckoutController.uniformAndOtherData.value}");
  }

  bool isUniformDataAvailable = false;

  @override
  Widget build(BuildContext context) {
    bool _isIos = _configurePlatform.getConfigurePlatformBool;
    return (_isIos)
        ? Material(
            child: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                leading: Material(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      CupertinoIcons.back,
                      color: CupertinoColors.activeBlue,
                    ),
                  ),
                ),
                middle: const Text(
                  'Information',
                  style: TextStyle(
                    color: CupertinoColors.activeBlue,
                  ),
                ),
                // This Cupertino segmented control has the enum "Sky" as the type.
              ),
              child: _CommonSafeAreaWidget(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text("Information"),
            ),
            body: _CommonSafeAreaWidget(context),
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

  // ignore: non_constant_identifier_names
  Widget _CommonSafeAreaWidget(BuildContext context) {
    bool _isIos = _configurePlatform.getConfigurePlatformBool;
    return SafeArea(
      child: Column(
        children: [
          //upper screen
          Expanded(
            child: SingleChildScrollView(
              physics: (_isIos)
                  ? const BouncingScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      _Details(
                          value: "Client Name", value2: widget.clientName!),
                      _Details(value: "Client Id", value2: widget.clientId!),
                      _Details(value: "Shift Id", value2: widget.shiftId!),
                      _Details(value: "Work Date", value2: widget.workDate!),
                      _Details(value: "Time On", value2: widget.timeOn!),
                      _Details(value: "Time Off", value2: widget.timeOff!),
                      _Details(value: "Task Id", value2: widget.taskId!),
                      _Details(
                          value: "Acitvity Name", value2: widget.activityName!),
                      //to show Venue Information data
                      Obx(
                        () => checkinCheckoutController
                                .uniformAndOtherData.isNotEmpty
                            ? Column(
                                children: [
                                  //to show (manager_to_report and supervisor_to_report) data
                                  _Details(
                                      value: "Manager To Report",
                                      value2: (checkinCheckoutController
                                                  .uniformAndOtherData[4] ==
                                              "")
                                          ? "No Manager"
                                          : checkinCheckoutController
                                              .uniformAndOtherData[4]),
                                  _Details(
                                      value: "Supervisor To Report",
                                      value2: (checkinCheckoutController
                                                  .uniformAndOtherData[5] ==
                                              "")
                                          ? "No Supervisor"
                                          : checkinCheckoutController
                                              .uniformAndOtherData[5]),
                                  _Details(
                                    value: "State",
                                    value2: checkinCheckoutController
                                        .uniformAndOtherData[0],
                                  ),
                                  _Details(
                                    value: "Suburb",
                                    value2: checkinCheckoutController
                                        .uniformAndOtherData[1],
                                  ),
                                  _Details(
                                    value: "Street",
                                    value2: checkinCheckoutController
                                        .uniformAndOtherData[2],
                                  ),
                                  _Details(
                                    value: "Postcode",
                                    value2: checkinCheckoutController
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
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          offset: const Offset(5.0, 5.0),
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
                            : (_isIos)
                                ? const CupertinoActivityIndicator(
                                    radius: 20.0, color: Colors.black)
                                : const CircularProgressIndicator(
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
                          child: _Details(
                              value: "CheckIn Time:",
                              value2:
                                  checkinCheckoutController.checkInTime.value),
                        ),
                      ),
                      //for checkout time
                      Obx(
                        () => Visibility(
                          visible: checkinCheckoutController
                              .showCheckOutTimeContainer.value,
                          child: _Details(
                              value: "CheckOut Time:",
                              value2:
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
              visible: checkinCheckoutController.showGoogleMap.value,
              child: Stack(
                children: [
                  //stacks first child
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: SizedBox(
                        height: 250,
                        width: double.infinity,
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
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(88, 170, 170, 170),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SizedBox(
                            height: 250,
                            width: double.infinity,
                            child: Center(
                              child: (_isIos)
                                  ? const CupertinoActivityIndicator(
                                      radius: 20.0, color: Colors.black)
                                  : const CircularProgressIndicator(
                                      color: Colors.blue,
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
          ),

          //
          //copied
          //bottom checkin and checkout buttons
          Obx(
            () => Visibility(
              visible: checkinCheckoutController
                  .checkinCheckoutButtonVisibility.value,
              child: Container(
                height: 50,
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: CupertinoButton(
                  color: checkinCheckoutController
                              .checkinCheckoutButtonText.value ==
                          "CHECK IN"
                      ? const Color.fromARGB(255, 31, 224, 37)
                      : const Color.fromARGB(255, 252, 39, 24),
                  onPressed: () async {
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
                          //mohali lat longs
                          // ["30.7123652", "76.707227"];
                          await checkinCheckoutController
                              .getLatLong(widget.clientId!);
                      print("this is the venue latlong $venueLatLong");

                      //to get the current time when user click on check in
                      var date = DateTime.now();
                      //to check if user try to check in only 15 minutes before the
                      //actual time
                      if (date.isAfter(DateTime.parse(
                                  '${widget.workDate!}T${widget.timeOn!}')
                              .subtract(const Duration(minutes: 15))) &&
                          date.isBefore(DateTime.parse(
                              '${widget.workDate!}T${widget.timeOn!}'))) {
                        // if (true) {
                        checkinCheckoutController.getLocation().then(
                          (value) async {
                            checkinCheckoutController.locationData =
                                await checkinCheckoutController.location
                                    .getLocation();
                            print(checkinCheckoutController.locationData);
                          },
                        ).then((value) async {
                          //checking user latlong with accordance to the shift place
                          //to get the straight distance between user
                          //and its shift place

                          //if venueLatLong or venueLocation is not empty
                          if (venueLatLong[0].isNotEmpty &&
                              venueLatLong[1].isNotEmpty) {
                            var userDistanceFromShiftPlace =
                                checkinCheckoutController.calculateDistane([
                              //latlong of user position
                              LatLng(
                                checkinCheckoutController
                                    .locationData!.latitude!,
                                checkinCheckoutController
                                    .locationData!.longitude!,
                              ),
                              // bathinda lat long
                              //const LatLng( 30.210995, 74.945473)

                              //latlong of the venueplace or clientid
                              LatLng(double.parse(venueLatLong[0]),
                                  double.parse(venueLatLong[1]))
                            ]);
                            if (userDistanceFromShiftPlace > 150) {
                              // if (false) {
                              checkinCheckoutController
                                  .showCircularProgressIndicator.value = false;

                              //if user is too away from shift
                              (_isIos)
                                  ? Constants.showCupertinoAlertDialog(
                                      child: Text(
                                          "You must be within the range of 150 Meters, You are ${userDistanceFromShiftPlace.round()} meters away from the shift place."),
                                      context: context)
                                  : Get.snackbar(
                                      'Message',
                                      'You must be within the range of 150 Meters, You are ${userDistanceFromShiftPlace.round()} meters away from the shift place.',
                                      duration: const Duration(seconds: 5),
                                    );
                              //to add marker
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
                            } else {
                              //if user is in the right place and right time
                              //from geocoding package
                              List<geocoding.Placemark> placemarks =
                                  await geocoding.placemarkFromCoordinates(
                                      checkinCheckoutController
                                          .locationData!.latitude!,
                                      checkinCheckoutController
                                          .locationData!.longitude!);
                              geocoding.Placemark place = placemarks[0];
                              checkinCheckoutController.addressLocation.value =
                                  '${place.street} ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.administrativeArea}, ${place.country}';
                              print(
                                  "this is the geocoding address ${checkinCheckoutController.addressLocation.value}");
                              checkinCheckoutController
                                  .showAddressLocation.value = true;
                              checkinCheckoutController
                                  .showCircularProgressIndicator.value = false;
                              //to add marker
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
                              //function to checked the user in database
                              checkinCheckoutController.checkinUser(
                                  widget.shiftId!,
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
                                .showCircularProgressIndicator.value = false;
                            (_isIos)
                                ? Constants.showCupertinoAlertDialog(
                                    child: const Text(
                                        "Place does not exist in the backend."),
                                    context: context)
                                : Get.snackbar('Message',
                                    'Place does not exist in the backend.');
                          }
                        });
                      } else {
                        checkinCheckoutController
                            .showCircularProgressIndicator.value = false;
                        (_isIos)
                            ? Constants.showCupertinoAlertDialog(
                                child: const Text(
                                    "Check In option is allowed only within 15 minutes before scheduled time of shift."),
                                context: context)
                            : Get.snackbar("Not Allowed",
                                "Check In option is allowed only within 15 minutes before scheduled time of shift.",
                                duration: const Duration(milliseconds: 1200));
                      }
                    } //
                    //if button value is CHECK OUT
                    else if (checkinCheckoutController
                            .checkinCheckoutButtonText.value ==
                        "CHECK OUT") {
                      (_isIos)
                          ? showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text("Confirm"),
                                  content: const Text(
                                      "Are you sure you want to checkout?"),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(
                                          color: CupertinoColors.destructiveRed,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        //to showCircularProgressIndicator
                                        checkinCheckoutController
                                            .showCircularProgressIndicator
                                            .value = true;
                                        print("checkingout");
                                        print(widget.shiftId!);
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
                                          checkinCheckoutController
                                              .checkoutUser(
                                                  widget.shiftId!,
                                                  (checkinCheckoutController
                                                          .locationData!
                                                          .latitude)
                                                      .toString(),
                                                  (checkinCheckoutController
                                                          .locationData!
                                                          .longitude)
                                                      .toString());
                                        });
                                        //to hide CircularProgressIndicator
                                        checkinCheckoutController
                                            .showCircularProgressIndicator
                                            .value = false;
                                        //to show checkin and checkout time
                                        //containers on the screen
                                        checkinCheckoutController
                                            .checkinCheckoutButtonVisibility
                                            .value = false;
                                        checkinCheckoutController
                                            .getCheckinCheckout(
                                                widget.shiftId!);
                                      },
                                    ),
                                  ],
                                );
                              },
                            )
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Confirm",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                          fontSize: 18,
                                        ),
                                  ),
                                  content: const Text(
                                      "Are you sure you want to checkout?"),
                                  actions: [
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor: const Color.fromARGB(
                                            255, 30, 89, 137),
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 20),
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 64, 160, 239)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor: const Color.fromARGB(
                                            255, 159, 40, 34),
                                        onTap: () {
                                          Get.back();
                                          //to showCircularProgressIndicator
                                          checkinCheckoutController
                                              .showCircularProgressIndicator
                                              .value = true;
                                          print("checkingout");
                                          print(widget.shiftId!);
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
                                            checkinCheckoutController
                                                .checkoutUser(
                                                    widget.shiftId!,
                                                    (checkinCheckoutController
                                                            .locationData!
                                                            .latitude)
                                                        .toString(),
                                                    (checkinCheckoutController
                                                            .locationData!
                                                            .longitude)
                                                        .toString());
                                          });
                                          //to hide CircularProgressIndicator
                                          checkinCheckoutController
                                              .showCircularProgressIndicator
                                              .value = false;
                                          //to show checkin and checkout time
                                          //containers on the screen
                                          checkinCheckoutController
                                              .checkinCheckoutButtonVisibility
                                              .value = false;
                                          checkinCheckoutController
                                              .getCheckinCheckout(
                                                  widget.shiftId!);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 20),
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
                                );
                              },
                            );
                    }
                  },
                  child: Obx(
                    () => Text(
                      checkinCheckoutController.checkinCheckoutButtonText.value,
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
        ],
      ),
    );
  }
}

class _Details extends StatelessWidget {
  String value;
  String value2;
  _Details({Key? key, required this.value, required this.value2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class CheckinCheckoutController extends GetxController {
  LocationData? locationData;
  var location = Location();
  bool? serviceEnabled;
  PermissionStatus? _permissionGranted;
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
  //
  //some functions to get the stratight distance between points
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
    response = await http.post(
        Uri.parse(Constants.getCompanyURL + '/api/get_venue/' + clientid));
    jsonData = jsonDecode(response.body);
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
    response = await http.post(
        Uri.parse(Constants.getCompanyURL + '/api/get_venue/' + clientid));
    jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 200) {
      var clientInformation = jsonData['data']['ClientInformation'];
      return [
        clientInformation['state'] ?? "No Data",
        clientInformation['suburb'] ?? "No Data",
        clientInformation['street'] ?? "No Data",
        clientInformation['postcode'] ?? "No Data",
        clientInformation['manager_to_report'] ?? "No Data",
        clientInformation['supervisor_to_report'] ?? "No Data",
        clientInformation['uniform_required'] ?? "No Data",
        clientInformation['uniform_description'] ?? "No Data"
      ];
    }
    return [];
  }

  //to get checkincheckout time from database
  Future getCheckinCheckout(String userAllowShiftId) async {
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
      if (jsonData['data']['check_in'] != "00:00:00") {
        showCheckInTimeContainer.value = true;
        checkInTime.value = jsonData['data']['check_in'];
        checkinCheckoutButtonText.value = "CHECK OUT";
        checkinCheckoutButtonVisibility.value = true;
      } else {
        showCheckInTimeContainer.value = false;
        checkInTime.value = "";
        checkinCheckoutButtonText.value = "CHECK IN";
        checkinCheckoutButtonVisibility.value = true;
      }
      if (jsonData['data']['check_out'] != "00:00:00") {
        showCheckOutTimeContainer.value = true;
        checkOutTime.value = jsonData['data']['check_out'];
        checkinCheckoutButtonVisibility.value = false;
        showGoogleMap.value = false;
      } else {
        showCheckOutTimeContainer.value = false;
        checkOutTime.value = "";
        checkinCheckoutButtonVisibility.value = true;
        showGoogleMap.value = true;
      }
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
    response = await http
        .post(Uri.parse(Constants.getCompanyURL + '/api/checkin'), body: {
      'user_id': Constants.getStaffID,
      'user_allow_shift_id': userAllowShiftId,
      'check_in_lat': checkinlat,
      'check_in_long': checkinlong
    });
    getCheckinCheckout(userAllowShiftId);
  }

  //to checkout the user into database
  Future checkoutUser(
      String userAllowShiftId, String checkoutlat, String checkoutlong) async {
    http.Response response;
    // ignore: prefer_typing_uninitialized_variables
    response = await http
        .post(Uri.parse(Constants.getCompanyURL + '/api/checkout'), body: {
      'user_id': Constants.getStaffID,
      'user_allow_shift_id': userAllowShiftId,
      'check_in_lat': checkoutlat,
      'check_in_long': checkoutlong
    });
    getCheckinCheckout(userAllowShiftId);
  }

  //
  //
  RxBool checkinCheckoutButtonVisibility = false.obs;
  RxString checkinCheckoutButtonText = "CHECK IN".obs;

  //show GoogleMap variable
  RxBool showGoogleMap = false.obs;
}
