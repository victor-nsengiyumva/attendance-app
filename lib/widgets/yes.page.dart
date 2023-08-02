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
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 70),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            'PF 3434',
                            style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Head Office',
                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '24 February 2023',
                            style: TextStyle(fontSize: 17, color: Colors.grey),
                          ),
                          SizedBox(height: 40,),
                          Row(
                            children: [
                              Column(
                                children: [
                                  
                                ],
                              )
                            ],
                          )
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
              SizedBox(
                height: 40,
              ),
              Expanded(child: DoneCheckin()),


            SizedBox(height: 70,),

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
                      MaterialPageRoute(builder: (context) => PhoneLoginPage()),
                      ((route) => false));
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('Done'),
                )),
            ],
          ),
        ));
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
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: (220/150)
         ),
      children: const [
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
        ),
        Card(
          color: Colors.green,
          child: SizedBox(
            height: 100,
            width: 100,
          ),
        )
      ],
    );
  }
}
