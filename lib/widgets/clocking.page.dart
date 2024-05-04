import 'package:attendance/coreFunctions/checkDevice.dart';
import 'package:attendance/backend.api/checkIn.dart';
import 'package:attendance/providers/error.clockpageProvider.dart';
import 'package:attendance/providers/timeInAndOut.provider.dart';
import 'package:attendance/providers/timeNow.provider.dart';
import 'package:attendance/widgets/yes.page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../backend.api/checkOut.dart';
import '../backend.api/checkRegistered.dart';
import '../providers/location.provider.dart';
import '../providers/user.provider.dart';
import 'package:intl/intl.dart';

class Clockin extends StatefulWidget {
  const Clockin({super.key});

  @override
  State<Clockin> createState() => _ClockinState();
}

class _ClockinState extends State<Clockin> {
  /// This init function checks the location and gets the current time as soon as this widget is
  /// added onto the widget tree so that the location and time are displayed immideiately
  @override
  void initState() {
    super.initState();
    checkLocation();
    getTime();
    greetingandClockButtonTextUpdate();
    didcheckin();
    didcheckout();
  }

  /// these are the several variables within the build function that change
  /// with given conditions to update the UI

  /// text on the big button
  String buttonLabel = 'Clock in';

  /// the greeting text at the topleft
  String greeting = 'Good morning';

  /// this holds the state of the error widget
  bool error = false;

  /// this is the default color of the big button
  Color _buttonColor = Colors.green;

  /// this holds the state of the ontap event of the big button
  bool isDisabled = false;

  /// this variable activates the circular progress bar depending on the state of the page
  bool isLoading = false;

  // variable controls state for refresh button
  bool refresh = false;

  /// The getTime function gets the current time and updates the provider that feeds the UI of the
  /// clockin page
  getTime() {
    TimeOfDay timeNow = TimeOfDay.now();
    Provider.of<TimeProvider>(context, listen: false).upDate(timeNow);
  }

  /// This function gets the device location from the locationProvider and compares your current location with the designated branch and
  /// updates the error provider with the error message which is sent to the error widget according to the status of your location.
  /// parameters for the Geolocator.distanceBetween are startLatitude, startLongitude, endLatitude, endLongitude
  checkLocation() async {
    var currentUser =
        Provider.of<UserProvider>(context, listen: false).getUser!;
    var position =
        Provider.of<LocationProvider>(context, listen: false).position;

    var userLongitude = double.parse(currentUser.location['longitude']);
    var userLatitude = double.parse(currentUser.location['latitude']);
    double distance = Geolocator.distanceBetween(
        position!.latitude, position.longitude, userLatitude, userLongitude);

    /// The checkdevice function checks the database whether you are using the same device that you used to register with
    /// and grants clockin/out if you are using the device you used for registration.
    /// the function returns

    bool trueDevice = await checkDevice(currentUser.deviceID);

    if (!trueDevice) {
      setState(() {
        isDisabled = true;
        _buttonColor = Colors.red;
        error = true;
        Provider.of<ErrorProvider>(
          context,
          listen: false,
        ).upDate(
            ' This device is not recognised as your registered device. Please use the device you used for creating an account.');
      });
    } else {
      if (distance > 1000) {
        setState(() {
          isDisabled = true;
          _buttonColor = Colors.red;
          error = true;
          Provider.of<ErrorProvider>(
            context,
            listen: false,
          ).upDate(
              'Your current location is beyond persmissible distance from your designated branch. Please be within allowable range to Clock in or out.');
        });
      }
    }

    setState(() {
      refresh = false;
    });
  }

  /// this function calculates the period of the day ie. whether its morning or afternoon and updates the greeting variable
  /// accordingly plus updating the clockin clock out trade off of the clocking button widget depending on whether its clockin time
  /// or clockout time.
  /// It is then called as the widget begins to build in the build function also in the refresh button incase the app is left dormant
  /// for a while.
  greetingandClockButtonTextUpdate() {
    final timeNow = TimeOfDay.now();

    // Convert the times to minutes past on the 24 hour clock
    final timeNowInMinutes = timeNow.hour * 60 + timeNow.minute;
    final startTimeInMinutes = 17 * 60; // 5 PM
    final endTimeInMinutes = 3 * 60; // 3 AM

    if (startTimeInMinutes <= endTimeInMinutes) {
      // If start and end times are in the same day
      if (timeNowInMinutes >= startTimeInMinutes &&
          timeNowInMinutes <= endTimeInMinutes) {
        setState(() {
          buttonLabel = 'Clock out';
        });
      }
    } else {
      // If start and end times are in different days, like 5PM to 3AM
      if (timeNowInMinutes >= startTimeInMinutes ||
          timeNowInMinutes <= endTimeInMinutes) {
        setState(() {
          buttonLabel = 'Clock out';
        });
      }
    }

    var timeNowInMinutesGreetings = timeNow.hour * 60 + timeNow.minute;
    var startTimeInMinutesGreetings = 12 * 60; // 5 PM
    var endTimeInMinutesGrettings = 0 * 60; // 3 AM

    if (startTimeInMinutesGreetings <= endTimeInMinutesGrettings) {
      // If start and end times are in the same day
      if (timeNowInMinutesGreetings >= startTimeInMinutesGreetings &&
          timeNowInMinutesGreetings <= endTimeInMinutesGrettings) {
        setState(() {
          greeting = 'Good afternoon';
        });
      }
    } else {
      // If start and end times are in different days, like 5PM to 3AM
      if (timeNowInMinutesGreetings >= startTimeInMinutesGreetings ||
          timeNowInMinutesGreetings <= endTimeInMinutesGrettings) {
        setState(() {
          greeting = 'Good afternoon';
        });
      }
    }
  }

  /// this function checks the database whether the person is done checking in and if so it
  /// deactivates the check in button and   changes its color to red on top of logging the error
  /// message into the error widget.
  /// when the checkRegistered function is called, it also stores the time of checkin in a provider so that
  /// it can be displayed to the user.
  didcheckin() async {
    var userCredential =
        Provider.of<UserProvider>(context, listen: false).getUser!;
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('d-MM-yyyy').format(currentDate);
    var timeinandoutprovider =
        Provider.of<TimeInAndOutProvider>(context, listen: false);

    bool result = await checkRegisteredIn(
        userCredential.id, formattedDate, timeinandoutprovider);
    if (result == true) {
      if (buttonLabel == "Clock out") {
        return;
      } else {
        setState(() {
          error = true;
          isDisabled = true;
          _buttonColor = Colors.red;
          Provider.of<ErrorProvider>(
            context,
            listen: false,
          ).upDate(
              'You are done clocking in for today. You will clock out at the end of the day.');
        });
      }
    }
  }

  /// this function does what the didcheckin function does but for the checkout process instead.
  didcheckout() async {
    var userCredential =
        Provider.of<UserProvider>(context, listen: false).getUser!;
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('d-MM-yyyy').format(currentDate);
    var timeinandoutprovider =
        Provider.of<TimeInAndOutProvider>(context, listen: false);

    await checkRegisteredOut(
        userCredential.id, formattedDate, timeinandoutprovider);
  }

  @override
  Widget build(BuildContext context) {
    var userCredential =
        Provider.of<UserProvider>(context, listen: true).getUser!;
    var location =
        Provider.of<LocationProvider>(context, listen: true).position;
    var timeandout = Provider.of<TimeInAndOutProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 235, 235),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 30),
          child: SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 0, 173, 238), // Change the text color here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Optional: Customize the button's shape
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Yes()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(17),
                  child: Text(
                    'Continue',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                )),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(255, 228, 227, 227),
                  color: Color.fromARGB(255, 0, 173, 238),
                ),
              )
            : Column(
                children: [
                  Container(
                    color: const Color.fromARGB(255, 0, 173, 238),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'APP-NAME',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              'assets/images/logo_new.png',
                              height: 80,
                              width: 150,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                    width: double.maxFinite,
                    color: const Color(0xFFD7DF23),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor:
                                      const Color.fromARGB(255, 234, 246, 255),
                                  child: Image.asset(
                                    'assets/images/office-worker.png',
                                    height: 29,
                                    width: 29,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      greeting,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      userCredential.PF,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          refresh = true;
                                          TimeOfDay timeNow = TimeOfDay.now();
                                          Provider.of<TimeProvider>(context,
                                                  listen: false)
                                              .upDate2(timeNow);
                                          greetingandClockButtonTextUpdate();
                                          checkLocation();
                                        });
                                      },
                                      child: Container(
                                          height: 46,
                                          width: 46,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 234, 246, 255),
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: refresh
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              228, 227, 227),
                                                      color: Color.fromARGB(
                                                          255, 0, 173, 238),
                                                    ),
                                                  )
                                                : Image.asset(
                                                    "assets/images/refresh.png",
                                                  ),
                                          ))),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              Provider.of<TimeProvider>(context, listen: true)
                                  .time!
                                  .format(
                                      context), // this turns the time into a string
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              DateFormat('EEEE, d MMMM').format(DateTime.now()),
                              style:
                                  TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 300,
                                width: double.maxFinite,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: isDisabled
                                            ? null
                                            : () async {
                                                DateTime currentDate =
                                                    DateTime.now();
                                                TimeOfDay currentTime =
                                                    TimeOfDay.now();
                                                String formattedDate =
                                                    DateFormat('d-MM-yyyy')
                                                        .format(currentDate);
                                                setState(() {
                                                  greetingandClockButtonTextUpdate();
                                                }); // this is incase the person hasnt hit the refresh so the big buttoon still says clock in instead of out
                                                if (buttonLabel == 'Clock in') {
                                                  setState(() {
                                                    isLoading = true;
                                                  });

                                                  var result = await checkIn(
                                                      userCredential.id,
                                                      currentTime
                                                          .format(context),
                                                      formattedDate.toString(),
                                                      timeandout);

                                                  if (result == true) {
                                                    setState(() {
                                                      error = true;
                                                      isDisabled = true;
                                                      _buttonColor = Colors.red;
                                                      Provider.of<
                                                          ErrorProvider>(
                                                        context,
                                                        listen: false,
                                                      ).upDate(
                                                          'You are done clocking in for today. You will clock out at the end of the day.');
                                                      isLoading = false;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      error = true;
                                                      Provider.of<
                                                          ErrorProvider>(
                                                        context,
                                                        listen: false,
                                                      ).upDate2(
                                                          'There has been an error and you are unable to clock in.Check your internet connection.');
                                                      isLoading = false;
                                                    });
                                                  }
                                                } else {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  var result = await checkOut(
                                                      userCredential.id,
                                                      currentTime
                                                          .format(context),
                                                      formattedDate.toString(),
                                                      timeandout);

                                                  if (result == true) {
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Yes()),
                                                      (route) => false,
                                                    );
                                                  } else {
                                                    setState(() {
                                                      error = true;
                                                      Provider.of<
                                                          ErrorProvider>(
                                                        context,
                                                        listen: false,
                                                      ).upDate2(
                                                          'There has been an error and you are unable to clock in.Check your internet connection.');
                                                      isLoading = false;
                                                    });
                                                  }
                                                }
                                              },
                                        child: Card(
                                          elevation: 6,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(95.0)),
                                          child: Container(
                                            width: 190,
                                            height: 190,
                                            decoration: BoxDecoration(
                                              color: _buttonColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/tap.png',
                                                    height: 50,
                                                    width: 50,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    buttonLabel,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.location_pin,
                                              size: 18,
                                              color: Color.fromARGB(
                                                  255, 0, 173, 238),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 25),
                                              child: SizedBox(
                                                  width: 230,
                                                  child: Text(
                                                    'Location : ${location!.latitude} , ${location.longitude}',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            error == false
                                ? const SizedBox(
                                    height: 60,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 234, 246, 255),
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 0, 173, 238),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(17),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/attention.png',
                                                  height: 20,
                                                  width: 20,
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: Text(
                                              '${Provider.of<ErrorProvider>(
                                                context,
                                                listen: true,
                                              ).error}',
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
