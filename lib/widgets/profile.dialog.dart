import 'package:attendance/widgets/avatar.dart';
import 'package:attendance/widgets/phone.login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfileDialog extends StatefulWidget {
  const ProfileDialog({super.key});

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // You can perform any additional actions after sign-out here.
    } catch (e) {
      print('Error occurred while signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Avatar(
                    photoUrl: '',
                    radius: 45,
                    borderWidth: 2.0,
                    borderColor: Color.fromARGB(255, 0, 173, 238),
                    onPressed: () {},
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 14),
                      height: 30,
                      width: 300,
                      child: Text(
                        'PF 3455',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      )),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 0),
                      height: 30,
                      width: 300,
                      child: Text(
                        'Head Office',
                      )),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: SizedBox(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 234, 246, 255),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            border: Border.all(color: Color.fromARGB(255, 221, 221, 221)),
                          ),
                          height: 55,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Attendance Logs',
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
                                bottom: BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
                                right: BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
                                left: BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
                                top: BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
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
                      SizedBox(height: 40,),
                      SizedBox(
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
                              _signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PhoneLoginPage()),
                                  ((route) => false));
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(12),
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
            ])));
  }
}