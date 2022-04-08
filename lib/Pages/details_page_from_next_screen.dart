import 'dart:convert';
import 'dart:math';
import 'package:emes/Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:emes/Pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class DetailsPageFromNextScreen extends StatefulWidget {
  DetailsPageFromNextScreen({Key? key}) : super(key: key);

  //initializing values
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(-33.865143, 151.209900), zoom: 11.5, tilt: 40);

  @override
  State<DetailsPageFromNextScreen> createState() => _DetailsPageFromNextScreenState();
}

class _DetailsPageFromNextScreenState extends State<DetailsPageFromNextScreen> {
  GoogleMapController? _googleMapController;

  final detailsPageFromNextScreenController = Get.put(DetailsPageFromNextScreenController());

  Marker? _firstMarker;
  Marker? _justMarker;

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
                          (detailsPageFromNextScreenController
                              .details[0])["client_name"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details("Client Id",
                          (detailsPageFromNextScreenController.details[0])["client_id"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details("Shift Id",
                          (detailsPageFromNextScreenController.details[0])["shift_id"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details("Work Date",
                          (detailsPageFromNextScreenController.details[0])["work_date"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details("Time On",
                          (detailsPageFromNextScreenController.details[0])["time_on"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details("Time Off",
                          (detailsPageFromNextScreenController.details[0])["time_off"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details("Task Id",
                          (detailsPageFromNextScreenController.details[0])["task_id"]),
                      const SizedBox(
                        height: 6,
                      ),
                      Details(
                          "Acitvity Name",
                          (detailsPageFromNextScreenController
                              .details[0])["activity_name"]),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                  
                  // Column(
                  //   children: [
                  //     //will visible when map will get your location
                  //     //after clicking checkin
                  //     Obx(
                  //       () => Visibility(
                  //         visible: detailsPageFromNextScreenController
                  //             .showAddressLocation.value,
                  //         child: Container(
                  //           height: 50,
                  //           decoration: const BoxDecoration(
                  //             color: Colors.white,
                  //           ),
                  //           child: Row(
                  //             children: [
                  //               Material(
                  //                 color: Color.fromARGB(255, 218, 218, 218),
                  //                 child: InkWell(
                  //                   onTap: () {
                  //                     Future.delayed(
                  //                         const Duration(milliseconds: 200),
                  //                         () {
                  //                       detailsPageFromNextScreenController
                  //                           .showAddressLocation.value = false;
                  //                       detailsPageFromNextScreenController
                  //                           .showCheckInTimeContainer
                  //                           .value = true;
                  //                       detailsPageFromNextScreenController
                  //                               .checkInTime.value =
                  //                           DateTime.now()
                  //                               .toString()
                  //                               .substring(0, 16);
                  //                       Get.snackbar(
                  //                           "Great! Location confirmed!",
                  //                           "Shift Confirmed and timer starts.",
                  //                           duration: const Duration(
                  //                               milliseconds: 1700));
                  //                     });
                  //                   },
                  //                   splashColor: Colors.blue,
                  //                   child: Container(
                  //                     height: 50,
                  //                     decoration: const BoxDecoration(
                  //                         // color: Color.fromARGB(255, 218, 218, 218),
                  //                         ),
                  //                     width: 120,
                  //                     padding: const EdgeInsets.symmetric(
                  //                         horizontal: 8),
                  //                     child: const Center(
                  //                       child: Text(
                  //                         "        Confirm \nYour Location:",
                  //                         style: TextStyle(
                  //                           fontWeight: FontWeight.w600,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               Expanded(
                  //                 child: Container(
                  //                   padding: const EdgeInsets.symmetric(
                  //                       horizontal: 8),
                  //                   child: Text(
                  //                     detailsPageFromNextScreenController
                  //                         .addressLocation.value,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Stack(
                  //       children: [
                  //         //stacks first child
                  //         Container(
                  //           height: 250,
                  //           width: Get.width,
                  //           // decoration: BoxDecoration(
                  //           //   color: Colors.red,
                  //           //   borderRadius: BorderRadius.circular(40),
                  //           // ),
                  //           child: GoogleMap(
                  //             mapType: MapType.normal,
                  //             markers: {
                  //               if (_firstMarker != null) _firstMarker!,
                  //               if (_justMarker != null) _justMarker!,
                  //             },
                  //             //to get lat lng of some place
                  //             onLongPress: addMarker,
                  //             initialCameraPosition:
                  //                 CheckinCheckoutPage._initialCameraPosition,
                  //             zoomControlsEnabled: false,
                  //             onMapCreated: (controller) =>
                  //                 _googleMapController = controller,
                  //           ),
                  //         ),
                  //         //stacks second child
                  //         //to show CircularProgressIndicator on map after
                  //         //clikcing checkin button
                  //         Obx(
                  //           () => Visibility(
                  //             visible: detailsPageFromNextScreenController
                  //                 .showCircularProgressIndicator.value,
                  //             child: Container(
                  //               height: 250,
                  //               width: Get.width,
                  //               color: Color.fromARGB(89, 223, 223, 223),
                  //               // color: Colors.red,
                  //               // decoration: BoxDecoration(
                  //               //   color: Colors.red,
                  //               //   borderRadius: BorderRadius.circular(40),
                  //               // ),
                  //               child: const Center(
                  //                 child: CircularProgressIndicator(),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                    
                  //   ],
                  // ),
                
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
      decoration: const BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontFamily: 'Ubuntu-Regular',fontWeight: FontWeight.w400,),
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

class DetailsPageFromNextScreenController extends GetxController {
  var details = Get.arguments;

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

  // //some function to get the stratight distance between points
  // double calculateDistane(List<LatLng> polyline) {
  //   double totalDistance = 0;
  //   for (int i = 0; i < polyline.length; i++) {
  //     if (i < polyline.length - 1) {
  //       // skip the last index
  //       totalDistance += getStraightLineDistance(
  //           polyline[i + 1].latitude,
  //           polyline[i + 1].longitude,
  //           polyline[i].latitude,
  //           polyline[i].longitude);
  //     }
  //   }
  //   return totalDistance;
  // }

  // double getStraightLineDistance(lat1, lon1, lat2, lon2) {
  //   var R = 6371; // Radius of the earth in km
  //   var dLat = deg2rad(lat2 - lat1);
  //   var dLon = deg2rad(lon2 - lon1);
  //   var a = sin(dLat / 2) * sin(dLat / 2) +
  //       cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  //   var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  //   var d = R * c; // Distance in km
  //   return d * 1000; //in m
  //   // return d; //in km
  // }

  // dynamic deg2rad(deg) {
  //   return deg * (pi / 180);
  // }

  //to get the latlong of the venueplace or clientid
  Future<List<String>> getLatLong(String clientid) async {
    http.Response response;
    // ignore: prefer_typing_uninitialized_variables
    var jsonData;
    response = await http.post(Uri.parse(
        'http://trusecurity.emesau.com/dev/api/get_venue/' + clientid));

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

  //to get checkincheckout time from database
  Future getCheckinCheckout(String userAllowShiftId) async {
    print("userAllowShiftId $userAllowShiftId");
    print('i here 4');
    http.Response response;
    // ignore: prefer_typing_uninitialized_variables
    var jsonData;
    response = await http.post(
        Uri.parse('http://trusecurity.emesau.com/dev/api/checkinoutTime'),
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
        print('i here 6');
      }
      if (jsonData['data']['check_out'] != "00:00:00") {
        showCheckOutTimeContainer.value = true;
        print("i here");
      }
      // if(jsonData['data']['check_in'] != "00:00:00" && jsonData['data']['check_out'] != "00:00:00"){
      //   checkinCheckoutButtonVisibility.value = false;
      //   print("i here2");
      // }
      if (jsonData['data']['check_in'] == "00:00:00" &&
          jsonData['data']['check_out'] == "00:00:00") {
      }
    }
  }

  //onit function
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCheckinCheckout(Get.arguments[0]['shift_id']);
    print('i here 3');
  }
}
