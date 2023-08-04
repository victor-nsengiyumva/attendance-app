import 'package:attendance/providers/location.provider.dart';
import 'package:attendance/widgets/phone.login.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:provider/provider.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  void _dialogCallback() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 234, 246, 255),
            iconColor: Colors.red,
            icon: const Icon(
              Icons.warning,
              size: 39,
            ),
            content: const Padding(
                padding: EdgeInsets.only(left: 14),
                child: Text(
                  'Enable Location on device',
                  style: TextStyle(color: Colors.black),
                )),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 173, 238),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _determinePosition();
                  },
                  child: const Text(
                    'Accept',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        });
  }

  void _dialogCallback2() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 234, 246, 255),
            iconColor: Colors.red,
            icon: const Icon(
              Icons.warning,
              size: 39,
            ),
            content: const Padding(
                padding: EdgeInsets.only(left: 14),
                child: Text(
                  'Enable Location on device',
                  style: TextStyle(color: Colors.black),
                )),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 173, 238),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _determinePosition();
                  },
                  child: const Text(
                    'Accept',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        });
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _dialogCallback();

        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        // return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        setState(() {});
        if (permission == LocationPermission.denied) {
          _dialogCallback2();
          print('ok you need to provide permission for the location');
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return;
          //Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('ok you need to provide permission for the location');
        _dialogCallback2();

        // Permissions are denied forever, handle appropriately.
        // return Future.error('Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      var trueLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy:
              LocationAccuracy.high); // the accuracy is set to high
      Provider.of<LocationProvider>(context, listen: false)
          .updatePosition(trueLocation);

      setState(() {});
    print("${trueLocation.accuracy} ${trueLocation.altitude} ${trueLocation.latitude} ${trueLocation.longitude} ${trueLocation.speed} ${trueLocation.timestamp} ${trueLocation.heading} wooork");
      // return trueLocation;
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<LocationProvider>(context, listen: false).isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(mainAxisSize: MainAxisSize.min, children: const [
                    CircularProgressIndicator(
                      backgroundColor: Color.fromARGB(255, 228, 227, 227),
                      color: Color.fromARGB(255, 0, 173, 238),
                    )
                  ]),
                  const SizedBox(height: 20),
                  const Text('Getting current location')
                ],
              ),
            )
          : const PhoneLoginPage(),
    );
  }
}
