import 'package:attendance/backend.api/checkIn.dart';
import 'package:attendance/providers/error.clockpageProvider.dart';
import 'package:attendance/widgets/yes.page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../backend.api/checkRegisted.dart';
import '../models/user.model.dart';
import '../providers/location.provider.dart';
import '../providers/user.provider.dart';
import 'function.checkDevice.dart';
import 'package:intl/intl.dart';

class Clockin extends StatefulWidget {
  const Clockin({super.key});

  @override
  State<Clockin> createState() => _ClockinState();
}

class _ClockinState extends State<Clockin> {
  @override
  void initState() {
    super.initState();
    checkLocation();
  }

  /// parameters for the Geolocator.distanceBetween are startLatitude, startLongitude, endLatitude, endLongitude
  checkLocation() async {
    var position =
        Provider.of<LocationProvider>(context, listen: false).position;
    double distance = Geolocator.distanceBetween(position!.latitude,
        position.longitude, 0.3508671638063489, 32.648231751906586);

    var trueDevice = checkDevice();

    if (trueDevice == false) {
      setState(() {
        error = true;
        Provider.of<ErrorProvider>(
          context,
          listen: false,
        ).upDate(
            ' This device is not recognised as your registered device. Please use the device you used for creating an account.');
      });
    } else {
      if (distance > 150) {
        setState(() {
          error = true;
          Provider.of<ErrorProvider>(
            context,
            listen: false,
          ).upDate(
              'Your current location is beyond persmissible distance from your designated branch. Please be within allowable range to Clock in or out.');
        });
      } else {
        var userId =
            Provider.of<UserProvider>(context, listen: false).getUser!.id;

        /// This [checkRegistered()] helper method checks the database in the table with todays date using the [ userId ] to see whether you registered for the day
        var status = checkRegistered();
        if (status == true) {
          setState(() {
            error = true;
            Provider.of<ErrorProvider>(
              context,
              listen: false,
            ).upDate('You are done with clocking in for today');
          });
        }
      }
    }
    print(distance);
  }

  var error = false;
  Color _buttonColor = Colors.green;
  @override
  Widget build(BuildContext context) {
    var userCredential =
        Provider.of<UserProvider>(context, listen: false).getUser!;
    var location =
        Provider.of<LocationProvider>(context, listen: true).position;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
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
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Continue',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                )),
          ),
        ),
        body: Column(
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
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
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
                                'Good morning,',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                userCredential.PF,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        TimeOfDay.now().format(context),
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       Text(
                       DateFormat('EEEE, d MMMM').format( DateTime.now()) ,
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () async {
                          DateTime currentDate = DateTime.now();
                          TimeOfDay currentTime = TimeOfDay.now();
                          String formattedDate = DateFormat('d-MM-yyyy').format(currentDate);

                          await checkIn(
                              userCredential.id,
                              currentTime.format(context),
                              formattedDate.toString());
                        },
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(95.0)),
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
                                  const Text(
                                    'Clock in',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
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
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 18,
                              color: Color.fromARGB(255, 0, 173, 238),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: SizedBox(
                                  width: 230,
                                  child: Text(
                                    'Location : ${location!.latitude} , ${location.longitude}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis),
                                  )),
                            )
                          ],
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
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 234, 246, 255),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 0, 173, 238),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(17),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
