import 'dart:async';
import 'dart:convert';

import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/constant/text_constant.dart';
import 'package:biddy_driver/model/base_model/ride_model.dart';
import 'package:biddy_driver/model/base_model/vehicle_model.dart';
import 'package:biddy_driver/model/driverinfo.dart';
import 'package:biddy_driver/model/ride_accept_request.dart';
import 'package:biddy_driver/network/common_api.dart';
import 'package:biddy_driver/provider/registration_provider.dart';
import 'package:biddy_driver/screen/driver/biddyridewait.dart';
import 'package:biddy_driver/util/get_date.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:biddy_driver/widgets/toast.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:circular_countdown_timer/countdown_text_format.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constant/app_constant.dart';
import '../../model/api_response.dart';
import '../../model/bidobj.dart';
import '../../model/driver_booking_request.dart';
import '../../model/ride_status_change_response.dart';
import '../../model/base_model/driver_model.dart';
import '../../route/app_routes.dart';
import '../../util/location.dart';
import '../../util/sharepreferences.dart';
import '../../widgets/driver/floating_appbar_wrapper.dart';
import 'package:http/http.dart' as http;

class HomeScreenDriver extends StatefulWidget {
  const HomeScreenDriver({super.key});
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenDriver> {
  DriverModel userData = DriverModel();
  GoogleMapController? googleMapController;
  int? userId;
  late Position currentPos;
  String? _currentAddress;
  Set<Marker> markers = {};
  LatLng centerLatLong = LatLng(18.5069331, 73.9252562);
  static bool isDialog = false;
  bool isLoading = true;



  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void _onMapCreated(GoogleMapController controller) {
      googleMapController = controller;
  }

  @override
  void initState() {
    // print('the online is ${AppConstant.info.data![0].isOnline!}');
    //isOnline= AppConstant.info.data![0].isOnline!;
    inData();
    getLocation();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isOnline = true;

  Vehicle? selectedVehicle;


  void selectVehicle(Vehicle vehicle) {
    selectedVehicle = vehicle;
  }


  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading == true
          ? Center(
            child: CircularProgressIndicator(),
          )
          : Stack(
              children: [
                detailsInfo!.data![0].driverId!.isActive == "true"
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: googleMap(),
                      )
                    : Center(
                        child: Icon(
                          Icons.offline_bolt_rounded,
                          size: query.width * 0.6,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 35, right: 5),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.menu);
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                            size: 30,
                          ))),
                ),
              ],
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingAppBarWrapper(
          height: 50,
          width: query.width,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Online Now',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Switch.adaptive(
                activeColor: Colors.white,
                inactiveTrackColor: Colors.grey,
                value: isOnline,
                onChanged: (value) async {
                  setState(() {
                    isOnline = value;
                  });
                  await changeStatus(isOnline.toString());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  late RegistrationProvider registrationProvider =
      RegistrationProvider("Ideal");

  Future<void> changeStatus(String isOnline) async {
    ApiResponse apiResponse =
        await registrationProvider.setOnlineOffline(isOnline);
  //  final res = json.decode(apiResponse.response);
   // print(res);
    if (apiResponse.status == 200 || apiResponse.status == 201) {
      SnackBar snackBar = SnackBar(
        content: Text("${apiResponse.response}"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      SnackBar snackBar = SnackBar(
        content: Text("${apiResponse.status}"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    detailsInfo = await CommonApi().getDriverOnlineOffLineInfo();

    setState(() {});
  }


  void _scaleDialog(RideData data) {
    isDialog = true;
    print('the type is ${data.typeOfRide!}');
    if (data.typeOfRide!.toLowerCase().contains(AppConstant.type_of_ride_bidding.toLowerCase())) {
      showGeneralDialog(
        context: context,
        pageBuilder: (ctx, a1, a2) {
          return Container();
        },
        transitionBuilder: (ctx, a1, a2, child) {
          var curve = Curves.easeInOut.transform(a1.value);
          return Transform.scale(
            scale: curve,
            child: _dialogBiddy(ctx, data),
          );
        },
        transitionDuration: const Duration(milliseconds: 3000),
      );
    } else {
      showGeneralDialog(
        context: context,
        pageBuilder: (ctx, a1, a2) {
          return Container();
        },
        transitionBuilder: (ctx, a1, a2, child) {
          var curve = Curves.easeInOut.transform(a1.value);
          return Transform.scale(
            scale: curve,
            child: _dialog(ctx, data),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      );
    }
  }

  TextEditingController _textFieldController = TextEditingController();
  String amountVal = "0";

  Widget _dialogBiddy(BuildContext context, RideData data) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.grey[50],
      titlePadding: const EdgeInsets.all(0),
      title: Container(
        decoration: BoxDecoration(
          color: Colors.green[600],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: const Center(
          child: Text(
            "Bid Ride Request",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      content: Container(
        height: 520,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${data.customerId!.firstName!} ${data.customerId!.lastName!}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              coutDownBiddyWideget(),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, color: Colors.green),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            data.startLocation!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Icon(Icons.arrow_downward, color: Colors.grey),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.flag, color: Colors.red),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            data.endLocation!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Estimated Fare: ₹${data.fare!.round()}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// VEHICLE LABEL
              const Text(
                "Select Vehicle",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),

              /// VEHICLE DROPDOWN
              DropdownButtonFormField<Vehicle>(
                value: selectedVehicle,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),

                  /// BORDER
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.5,
                    ),
                  ),
                ),
                items: detailsInfo!.data!.map((vehicle) {
                  return DropdownMenuItem<Vehicle>(
                    value: vehicle,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blue.shade50,
                          child: const Icon(
                            Icons.directions_car,
                            size: 16,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                vehicle.model ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 0),
                              Text(
                                "${vehicle.vehicleLicensePlateNumber} • ${vehicle.typeOfVehicle}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (vehicle) {
                  if (vehicle != null) {
                    selectVehicle(vehicle);
                  }
                },
              ),

              const SizedBox(height: 20),

              /// BID AMOUNT LABEL
              const Text(
                "Your Bid Amount",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),

              /// BID AMOUNT FIELD
              TextField(
                controller: _textFieldController,
                keyboardType: TextInputType.number,
                onChanged: (value) => amountVal = value,
                decoration: InputDecoration(
                  hintText: "Enter amount",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 14),

                  /// BORDER
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.5,
                    ),
                  ),

                  prefixIcon: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.currency_rupee,
                      size: 18,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          )

          ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[600],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          ),
          onPressed: () {
            isDialog = false;
            sendBid(data);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.send, color: Colors.white),
          label: const Text(
            "Send Bid",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        TextButton.icon(
          onPressed: () {
            isDialog = false;
            callTimer();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close, color: Colors.red),
          label: const Text(
            "Cancel",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      ],
    );
  }


  Widget _dialog(BuildContext context, RideData data) {
    return AlertDialog(
      title: Center(child: Text("Ride Request")),
      content: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextView(
                title:"${data.customerId!.firstName??"" + " " + data.customerId!.lastName!??""}",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            SizedBox(
              height: 16,
            ),
            Center(
              child: coutDownWideget(),
            ),
            SizedBox(
              height: 16,
            ),
            TextView(
                title:"${data.startLocation!}",
            color: Colors.green,
            fontWeight: FontWeight.bold,
                fontSize: 16),
            SizedBox(
              height: 10,
            ),
            Text("to",
                style: TextStyle(
                  fontSize: 16,
                )),
            SizedBox(
              height: 10,
            ),
            TextView(
                title:"${data.endLocation!}",
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            SizedBox(
              height: 16,
            ),

            TextView(
                title:"\$ ${data.fare!}",
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              isDialog = false;
              callAccept(data);
              Navigator.of(context).pop();
            },
            child: const Text(
              "Accept",
              style: TextStyle(color: Colors.green, fontSize: 17),
            )),
        TextButton(
            onPressed: () {
              isDialog = false;
              callTimer();
              Navigator.of(context).pop();
            },
            child: const Text(
              "Reject",
              style: TextStyle(color: Colors.red, fontSize: 17),
            ))
      ],
    );
  }

  final int _duration = 7;
  final CountDownController _controller = CountDownController();

  coutDownWideget() {
    return CircularCountDownTimer(
      // Countdown duration in Seconds.
      duration: _duration,
      initialDuration: 0,
      controller: _controller,
      width: 80,
      height: 60,
      ringColor: Colors.grey.shade300,
      ringGradient: null,
      fillColor: Colors.purpleAccent[100]!,
      fillGradient: null,
      backgroundColor: Colors.purple[500],
      backgroundGradient: null,
      strokeWidth: 10.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textFormat: CountdownTextFormat.S,
      isReverse: false,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {},
      onComplete: () {
        // Here, do whatever you want
        //debugPrint('Countdown Ended');
        isDialog = false;
        callTimer();
        Navigator.of(context).pop();
      },

      // This Callback will execute when the Countdown Changes.
      onChange: (String timeStamp) {},

      timeFormatterFunction: (defaultFormatterFunction, duration) {
        if (duration.inSeconds == 0) {
          // only format for '0'
          return "0";
        } else {
          // other durations by it's default format
          return Function.apply(defaultFormatterFunction, [duration]);
        }
      },
    );
  }

  final int _durationBiddy = 10;

  coutDownBiddyWideget() {
    return CircularCountDownTimer(
      // Countdown duration in Seconds.
      duration: _durationBiddy,
      initialDuration: 0,
      controller: _controller,
      width: 80,
      height: 60,
      ringColor: Colors.grey[300]!,
      ringGradient: null,
      fillColor: Colors.purpleAccent[100]!,
      fillGradient: null,
      backgroundColor: Colors.purple[500],
      backgroundGradient: null,
      strokeWidth: 10.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textFormat: CountdownTextFormat.S,
      isReverse: false,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {},
      onComplete: () {
        // Here, do whatever you want
        //debugPrint('Countdown Ended');
        isDialog = false;
        callTimer();
        Navigator.of(context).pop();
      },

      // This Callback will execute when the Countdown Changes.
      onChange: (String timeStamp) {},

      timeFormatterFunction: (defaultFormatterFunction, duration) {
        if (duration.inSeconds == 0) {
          // only format for '0'
          return "0";
        } else {
          // other durations by it's default format
          return Function.apply(defaultFormatterFunction, [duration]);
        }
      },
    );
  }

  DriverDetailsInfo? detailsInfo;

  void inData() async {
    detailsInfo = await CommonApi().getDriverOnlineOffLineInfo();
    isOnline =
        detailsInfo!.data![0].driverId!.isActive == "true" ? true : false;
    userData = await LocalSharePreferences().getLoginData();
    setState(() {
      userId = userData.data!.id;
    });
  }

  Future<void> getLocation() async {
    try {
      currentPos = await CurrentLocation().getLocation();
      setState(() {}); // Reflect position change in UI
      getAddressFromLatLng(currentPos); // You might want to await this too
      isLoading = false;
      callTimer(); // If this is tied to location updates
    } catch (e) {
      print("Location error: $e");
      // You could show a dialog or toast here
    }
  }

  Future<Position> getCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(currentPos.latitude, currentPos.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(currentPos.latitude, currentPos.longitude),
                zoom: 14)));
        markers.clear();
        markers.add(Marker(
            markerId: MarkerId('currentLocation'),
            position: LatLng(position.latitude, position.longitude)));
      });

      googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(currentPos.latitude, currentPos.longitude),
              zoom: 14)));
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<LatLng?> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        return LatLng(location.latitude, location.longitude);
      }
    } catch (e) {
      print('Error getting location: $e');
    }
    return null;
  }

  googleMap() {
    return GoogleMap(
      markers: markers,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: centerLatLong,
        zoom: 14.0,
      ),
      onMapCreated: _onMapCreated,
    );
  }

  late Timer mytimer;

  callTimer() {
    if (isOnline) {
      mytimer = Timer.periodic(Duration(seconds: 5), (timer) {
        if (isDialog) {
          mytimer.cancel();
        } else if (!isOnline) {
          mytimer.cancel();
        } else {
          // _scaleDialog1();
          getRides();
        }
      });
    } else {
      if (mytimer != null) {
        mytimer.cancel();
      }
    }
  }

  callBiddyTimer() {
    if (isOnline) {
      mytimer = Timer.periodic(Duration(seconds: 10), (timer) {
        if (isDialog) {
          mytimer.cancel();
        } else if (!isOnline) {
          mytimer.cancel();
        } else {
          // _scaleDialog1();
          getRides();
        }
      });
    } else {
      if (mytimer != null) {
        mytimer.cancel();
      }
    }
  }

  Future<void> getRides() async {
    userData = await LocalSharePreferences().getLoginData();
    int? uId = userData.data!.id;
    ;
    int cabCategory = 1;
    int maxDist = 22;
    String myUrl = '${APIConstants.GETPENDINGRIDES}$uId&driverLatitude=${currentPos.latitude.toString()}&driverLongitude=${currentPos.longitude.toString()}';
   /* String myUrl =
        "http://ec2-13-234-38-217.ap-south-1.compute.amazonaws.com:8080/biddy/api/rides/getPendingRidesByDriverId2?driverId=3&driverLatitude=18.5070088&driverLongitude=73.9253853";
*/
    print('get pending rides api : $myUrl');
    ApiResponse response = await AppConstant.apiHelper.ApiGetData(myUrl);
    if (response.status == 200) {
      final body = json.decode(response.response);
      RideBookingModel rideBooking = RideBookingModel.fromJson(body);
      if (rideBooking.data != null)
        /*if(rideBooking.data![0].bokkingType!.contains("Default")){
        _scaleDialog(rideBooking.data![0]);
      }else{
        _scaleDialog(rideBooking.data![0]);
      }*/
        _scaleDialog(rideBooking.data![0]);
    } else {
      // ToastMessage.show(context, message)
      print('Request failed with status: ${response.response}.');
    }
  }

  void callAccept(RideData rideBookingData) async {
    mytimer.cancel();
    isLoading = true;
    setState(() {});
    userData = await LocalSharePreferences().getLoginData();
    int? uId = userData.data!.id;
    DriverDetailsInfo detailsInfo =
        await CommonApi().getDriverOnlineOffLineInfo();
    RideAcceptRequest acceptRequest = RideAcceptRequest();
    acceptRequest.id = rideBookingData.id;
    acceptRequest.fare = rideBookingData.fare;
    acceptRequest.status = AppConstant.status_accepted;
    acceptRequest.driverId = uId;
    acceptRequest.paymentMode = rideBookingData.paymentMethod;
    acceptRequest.vehicleId = 1;

    String url = "${APIConstants.BASE_URL}api/rides/acceptRideFromUser";
    print("RideBooking Url : $url");
    Map<String, dynamic>
        data =
        {
      "bidAmount": rideBookingData.bidAmount,
      "driverId": uId,
      "fare": rideBookingData.fare,
      "id": rideBookingData.id,
      "paymentMode": rideBookingData.paymentMethod,
      "status": "ACCEPTED",
      "vehicleId": detailsInfo.data![0].id
    };
    print(data);
    ApiResponse apiResponse =
        await AppConstant.apiHelper.putDataArgument(url, data);
    print(apiResponse.status.toString());
    print(apiResponse.response);
    RideStatusChangeResponse rideBooking =
        RideStatusChangeResponse.fromJson(json.decode(apiResponse.response));
    if (rideBooking.success == true) {
      Navigator.pushReplacementNamed(context, AppRoutes.bookedride,
          arguments: rideBooking.data);
    } else {
      ToastMessage.show(context, rideBooking.message.toString());
    }
    isLoading = false;
    setState(() {});
  }
  Future<void> sendBid(RideData data) async {
    try {
      if (mytimer != null) {
        mytimer.cancel();
      }

      isLoading = true;
      setState(() {});

      userData = await LocalSharePreferences().getLoginData();
      final int uId = userData.data!.id!;

      RideBid rideBid = RideBid()
        ..id = 0
        ..rideId = data.id
        ..driverId = uId
        ..bidAmount = int.tryParse(amountVal) ?? 0
        ..status = "PENDING"
        ..vehicleId = selectedVehicle!.id
        ..lattitude = currentPos.latitude.toString()   // ✅ FIXED
        ..longitude = currentPos.longitude.toString(); // ✅ FIXED

      final String url = APIConstants.BID_SEND_TO_USER;
      debugPrint("Send Bid Url::: $url");
      debugPrint("Request::: ${rideBid.toJson()}");

     /* ApiResponse apiResponse = await AppConstant.apiHelper
          .postDataArgument(url, rideBid.toJson());*/


      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(rideBid.toJson()),
      );

      debugPrint("Response::: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BiddyWaitScreen(
              ride: data,
              driverId: uId,
            ),
          ),
        );
      } else {
        ToastMessage.show(context, "Try again");
      }
    } catch (e) {
      debugPrint("Send bid error: $e");
      ToastMessage.show(context, "Something went wrong");
    } finally {
      isLoading = false;
      isDialog = false;
      if (mounted) setState(() {});
    }
  }

}
