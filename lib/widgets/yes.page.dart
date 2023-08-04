import 'package:attendance/painter/billboard.dart';
import 'package:attendance/widgets/phone.login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Yes extends StatefulWidget {
  const Yes({super.key});

  @override
  State<Yes> createState() => _YesState();
}

class _YesState extends State<Yes> {
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
                    _signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PhoneLoginPage()),
                        ((route) => false));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
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
                            children: const [
                              Text(
                                'PF 3434',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Head Office',
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
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/placeholder.png'),
                            radius: 23,
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
                    height: 80,
                  ),
                  const Expanded(child: SingleChildScrollView(child: DoneCheckin())),
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
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Padding(
        padding: EdgeInsets.only(left: 6),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Wed. 23 August, 23',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          '08:34 am',
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
          SizedBox(width: 4,),
          Expanded(
            flex:1,
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
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          '09:34 am',
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
                SizedBox(width: 4,),

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
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          '13h 00m',
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
                    SizedBox(width: 4,),

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
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          '5h 34m',
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
