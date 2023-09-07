import 'package:attendance/widgets/attendanceHistory.dart';
import 'package:attendance/widgets/avatar.dart';
import 'package:attendance/widgets/login.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../providers/error.clockpageProvider.dart';
import '../providers/timeInAndOut.provider.dart';
import '../providers/user.provider.dart';
import '../test.dart';

class ProfileDialog extends StatefulWidget {
  const ProfileDialog({super.key});

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  @override
  Widget build(BuildContext context) {
    var userCredential =
        Provider.of<UserProvider>(context, listen: true).getUser!;
    return Center(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Divider(thickness: 1.3,),
                    SizedBox(height: 10,),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20,),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                   children: [
                    
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right:20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Avatar(
                          photoUrl: '',
                          radius: 40,
                          borderWidth: 2.0,
                          borderColor: Color.fromARGB(255, 0, 173, 238),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 300,
                                  child: Text(
                                    userCredential.PF,
                                    style: TextStyle(
                                        fontSize: 23, fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 0),
                                  height: 30,
                                  width: 300,
                                  child: Text(
                                    userCredential.location['name'],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: SizedBox(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => History()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 234, 246, 255),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                border: Border.all(
                                    color: Color.fromARGB(255, 221, 221, 221)),
                              ),
                              height: 55,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 17, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Attendance History',
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 234, 246, 255),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromARGB(255, 221, 221, 221)),
                                    right: BorderSide(
                                        color: Color.fromARGB(255, 221, 221, 221)),
                                    left: BorderSide(
                                        color: Color.fromARGB(255, 221, 221, 221)),
                                    top: BorderSide(
                                        color: Color.fromARGB(255, 221, 221, 221)),
                                  )),
                              height: 55,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 17, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Change Device',
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 0, 173,
                                      238), // Change the text color here
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Optional: Customize the button's shape
                                  ),
                                ),
                                onPressed: () {
                                  Provider.of<TimeInAndOutProvider>(context,
                                          listen: false)
                                      .clear();
                                  Provider.of<ErrorProvider>(context, listen: false)
                                      .clear();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MyApp()),
                                      (Route<dynamic> route) => false);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(17),
                                  child: Text(
                                    'SignOut',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 17),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ])),
          ],
        ));
  }
}
