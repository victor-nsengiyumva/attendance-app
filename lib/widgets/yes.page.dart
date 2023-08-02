import 'package:attendance/painter/billboard.dart';
import 'package:attendance/widgets/phone.login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
          body: Stack(children: [
        Container(
          height: 120,
          width: double.maxFinite,
          color: Colors.blue,
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 70),
          child: Column(
            children: [
              Card(
                elevation: 4,
                margin: EdgeInsets.all(0),
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
                            style: TextStyle(fontSize: 17, color: Colors.grey),
                          ),
                        ],
                      ),
                      CircleAvatar(
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
                children: [
                  Expanded(child: CustomLine()),
                  Expanded(child: CustomLine())
                ],
              ),
              Card(
                color: Color.fromARGB(255, 234, 246, 255),
                elevation: 2,
                margin: EdgeInsets.all(0),
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
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
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ],
                          ),
                          VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 9,
                            endIndent: 9,
                          ),
                          Column(
                            children: [
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
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ],
                          ),
                          VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 9,
                            endIndent: 9,
                          ),
                          Column(
                            children: [
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
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 60,
              ),
              Expanded(child: DoneCheckin()),
              SizedBox(
                height: 70,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Change the text color here
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
                            builder: (context) => PhoneLoginPage()),
                        ((route) => false));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text('Done'),
                  )),
            ],
          ),
        ),
      ])),
    );
  }
}

class Checkin extends StatefulWidget {
  const Checkin({super.key});

  @override
  State<Checkin> createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkin> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkin> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            'Wed. 23 August, 23',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: (220 / 150)),
            children: [
              Card(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              child: Image.asset(
                                'assets/images/check-in.png',
                                height: 17,
                                width: 17,
                              ),
                              backgroundColor: Color.fromARGB(255, 234, 246, 255),
                            ),
                            SizedBox(width: 10,),
                            Text('Check In',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
                          ],
                        ),
                        SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text('08:34 am',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                        ),SizedBox(height:14),
                        Text('On time',style: TextStyle(fontSize: 13,color: Colors.grey),)
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.green,
                child: SizedBox(
                  height: 100,
                  width: 100,
                ),
              ),
              Card(
                color: Colors.green,
                child: SizedBox(
                  height: 100,
                  width: 100,
                ),
              ),
              Card(
                color: Colors.green,
                child: SizedBox(
                  height: 100,
                  width: 100,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
