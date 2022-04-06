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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Details(
                          "Client Name",
                          (checkinCheckoutController
                              .details[0])["client_name"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details("Client Id",
                          (checkinCheckoutController.details[0])["client_id"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details("Shift Id",
                          (checkinCheckoutController.details[0])["shift_id"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details("Work Date",
                          (checkinCheckoutController.details[0])["work_date"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details("Time On",
                          (checkinCheckoutController.details[0])["time_on"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details("Time Off",
                          (checkinCheckoutController.details[0])["time_off"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details("Task Id",
                          (checkinCheckoutController.details[0])["task_id"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details(
                          "Acitvity Name",
                          (checkinCheckoutController
                              .details[0])["activity_name"]),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        // margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Timer:",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text("00:00")
                          ],
                        ),
                      ),
                      //some space
                      const SizedBox(
                        height: 6,
                      ),
                      //will show checkin time and container
                      Obx(
                        () => Visibility(
                          visible: checkinCheckoutController
                              .showCheckInTimeContainer.value,
                          child: Container(
                            // margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "CheckIn Time:",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Text(checkinCheckoutController
                                    .checkInTime.value),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //some space
                      const SizedBox(
                        height: 6,
                      ),
                      //will show checkout time and container
                      Obx(
                        () => Visibility(
                          visible: checkinCheckoutController
                              .showCheckOutTimeContainer.value,
                          child: Container(
                            // margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "CheckOut Time:",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Text(checkinCheckoutController
                                    .checkOutTime.value),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      //will visible when map will get your location
                      //after clicking checkin
                      Obx(
                        () => Visibility(
                          visible: checkinCheckoutController
                              .showAddressLocation.value,
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
                                          const Duration(milliseconds: 200),
                                          () {
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
                                        Get.snackbar(
                                            "Great! Location confirmed!",
                                            "Shift Confirmed and timer starts.",duration: const Duration(milliseconds: 1700));
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
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
                                if (_firstMarker != null) _firstMarker!
                              },
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
                ],
              ),
            ),
            //
            //bottom checkin and checkout buttons
            Container(
              child: Row(
                children: [
                  //checkout button
                  Expanded(
                    child: Material(
                      color: Color.fromARGB(255, 210, 210, 210),
                      child: InkWell(
                        onTap: () {
                          if(checkinCheckoutController.showCheckOutTimeContainer.value != true && checkinCheckoutController.showCheckInTimeContainer == true){
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 105,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15,vertical: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Confirm",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!.copyWith(fontSize: 18,),
                                            ),
                                            Text("Are you sure you want to checkout?"),
                                            Container(child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                                              Material(color: Colors.transparent,child: InkWell(splashColor: Color.fromARGB(255, 30, 89, 137),onTap: (){Get.back();},child: Container(padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),child: Text("Cancel",style: const TextStyle(color: Color.fromARGB(255, 64, 160, 239)),),),),),
                                              Material(color: Colors.transparent,child: InkWell(splashColor:Color.fromARGB(255, 159, 40, 34),onTap: (){checkinCheckoutController.checkOutTime.value = DateTime.now().toString().substring(0,16);checkinCheckoutController.showCheckOutTimeContainer.value = true;Get.back();},child: Container(padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),child: Text("Confirm",style: const TextStyle(color: Color.fromARGB(255, 230, 64, 55),),),),),),
                                            ],),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },);
                          }else {
                            Get.snackbar("Opps!", "You have already Checked out from this shift.",duration: const Duration(milliseconds: 1200));
                          }
                        },
                        splashColor: Color.fromARGB(255, 83, 83, 83),
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
                  // Container(
                  //   height: 40,width: 1,decoration:const BoxDecoration(color: Color.fromARGB(255, 172, 172, 172),),
                  // ),
                  //checkin button
                  Expanded(
                    child: Material(
                      color: Color.fromARGB(255, 194, 194, 194),
                      child: InkWell(
                        onTap: () {
                          if(checkinCheckoutController.showCheckInTimeContainer.value != true){
                            checkinCheckoutController
                              .showCircularProgressIndicator.value = true;
                          var date = DateTime.now();
                          // if (date.toString().substring(0, 10) ==
                          //         checkinCheckoutController.details[0]
                          //             ['work_date'] &&
                          //     date.weekday.toString() ==
                          //         checkinCheckoutController.details[0]
                          //             ['day_of_shift']) {
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
                            ).then(
                              (value) async {
                                GeoCode geoCode = GeoCode();
                                Address address =
                                    await geoCode.reverseGeocoding(
                                        latitude: checkinCheckoutController
                                            .locationData!.latitude!,
                                        longitude: checkinCheckoutController
                                            .locationData!.longitude!);
                                checkinCheckoutController
                                        .addressLocation.value =
                                    "${address.countryName}(${address.countryCode}) ${address.region}(${address.postal}) ${address.streetAddress} ${address.streetNumber}";
                                checkinCheckoutController
                                    .showAddressLocation.value = true;
                                checkinCheckoutController
                                    .showCircularProgressIndicator
                                    .value = false;
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
                          } else {
                            checkinCheckoutController
                                .showCircularProgressIndicator.value = false;
                            Get.snackbar("Not Allowed.",
                                "Check In option is allowed only 15 minutes before scheduled time of shift.",duration: const Duration(milliseconds: 1200));
                          }
                          }else {
                            Get.snackbar("Opps!", "You have already Checked in into this shift.",duration: const Duration(milliseconds: 1200));
                          }
                        },
                        splashColor: Color.fromARGB(255, 83, 83, 83),
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

  Widget Details(String value, String value2) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headline5,
          ),
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
}
