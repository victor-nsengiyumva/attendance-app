import 'package:attendance/painter/billboard.dart';
import 'package:attendance/widgets/attendanceHistory.dart';
import 'package:attendance/widgets/login.page.dart';
import 'package:attendance/widgets/profile.dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../backend.api/checkRegistered.dart';
import '../main.dart';
import '../providers/dateLogsProvider.dart';
import '../providers/error.clockpageProvider.dart';
import '../providers/timeInAndOut.provider.dart';
import '../providers/user.provider.dart';
import '../test.dart';

class Yes extends StatefulWidget {
  const Yes({super.key});

  @override
  State<Yes> createState() => _YesState();
}

class _YesState extends State<Yes> {
  @override
  Widget build(BuildContext context) {
    var userCredential =
        Provider.of<UserProvider>(context, listen: true).getUser!;
    return SafeArea(
      child: Scaffold(
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
                    Provider.of<TimeInAndOutProvider>(context, listen: false)
                        .clear();
                    Provider.of<ErrorProvider>(context, listen: false)
                        .clear();
                    Provider.of<DateLogsModelProvider>(context, listen: false)
                        .clear();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const MyApp()),
                        (Route<dynamic> route) => false);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(17),
                    child: Text(
                      'Done',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  )),
            ),
          ),
          body: Stack(children: [
            Column(
              children: [
                Container(
                  height: 110,
                  width: double.maxFinite,
                  color: const Color.fromARGB(255, 0, 173, 238),
                ),
                Container(
                  height: 10,
                  width: double.maxFinite,
                  color: const Color(0xFFD7DF23),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userCredential.PF,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                userCredential.location['name'],
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'August 2023',
                                style:
                                    TextStyle(fontSize: 17, color: Colors.grey),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      contentPadding:
                                          EdgeInsets.only(top: 20, bottom: 20),
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      title: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text('Profile Settings'),
                                      )),
                                      content: SizedBox(
                                          height: 450, child: ProfileDialog()),
                                    );
                                  });
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/placeholder.png'),
                              radius: 23,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(child: CustomLine()),
                      Expanded(child: CustomLine())
                    ],
                  ),
                  Card(
                    color: const Color.fromARGB(255, 234, 246, 255),
                    elevation: 2,
                    margin: const EdgeInsets.all(0),
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: const [
                                  Text(
                                    'Absent',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '4',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              const VerticalDivider(
                                color: Colors.grey,
                                thickness: 1,
                                indent: 9,
                                endIndent: 9,
                              ),
                              Column(
                                children: const [
                                  Text(
                                    'Attendance',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '21',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              const VerticalDivider(
                                color: Colors.grey,
                                thickness: 1,
                                indent: 9,
                                endIndent: 9,
                              ),
                              Column(
                                children: const [
                                  Text(
                                    'Overtime',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '2',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Expanded(
                      child: SingleChildScrollView(child: DoneCheckin())),
                ],
              ),
            ),
          ])),
    );
  }
}

class DoneCheckin extends StatefulWidget {
  const DoneCheckin({super.key});

  @override
  State<DoneCheckin> createState() => _DoneCheckinState();
}

class _DoneCheckinState extends State<DoneCheckin> {
  @override
  Widget build(BuildContext context) {
    var timeinandout =
        Provider.of<TimeInAndOutProvider>(context, listen: true);

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: EdgeInsets.only(left: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat('EEEE, d MMMM').format(DateTime.now()),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const History()));
              },
              child: Padding (
                padding:EdgeInsets.only(right:7),
                child: Text("Logs",style: TextStyle(color:const Color.fromARGB(
                          255, 0, 173, 238), fontWeight: FontWeight.bold,fontSize: 15),),
              )),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: Card(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                const Color.fromARGB(255, 234, 246, 255),
                            child: Image.asset(
                              'assets/images/check-in.png',
                              height: 17,
                              width: 17,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Check In',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          timeinandout.timeIn.isEmpty
                              ? '- -'
                              : timeinandout.timeIn,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'On time',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            flex: 1,
            child: Card(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                const Color.fromARGB(255, 234, 246, 255),
                            child: Image.asset(
                              'assets/images/check-out.png',
                              height: 22,
                              width: 22,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Check out',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          timeinandout.timeOut.isEmpty
                              ? '- -'
                              : timeinandout.timeOut,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Overtime',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        width: 4,
      ),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: Card(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                const Color.fromARGB(255, 234, 246, 255),
                            child: Image.asset(
                              'assets/images/worktime.png',
                              height: 17,
                              width: 17,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Work time',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          timeinandout.workTime,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Overtime',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            flex: 1,
            child: Card(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 234, 246, 255),
                            radius: 15,
                            child: Image.asset(
                              'assets/images/overtime.png',
                              height: 17,
                              width: 17,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Overtime',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          timeinandout.overtime,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        '_ _',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
