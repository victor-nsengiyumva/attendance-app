import 'dart:convert';
import 'package:attendance/backend.api/checkRegistered.dart';
import 'package:attendance/backend.api/login.dart';
import 'package:attendance/models/user.model.dart';
import 'package:attendance/providers/timeInAndOut.provider.dart';
import 'package:attendance/providers/user.provider.dart';
import 'package:attendance/widgets/clocking.page.dart';
import 'package:attendance/widgets/signup.page.dart';
import 'package:attendance/widgets/yes.page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _emailField = TextEditingController();
  // ignore: unused_field
  final TextEditingController _passwordField = TextEditingController();
  String errorText = '';
  bool loading = false;
  bool passwordvisible = false;

  didcheckin() async {
    var userCredential =
        Provider.of<UserProvider>(context, listen: false).getUser!;
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('d-MM-yyyy').format(currentDate);
    var timeinandoutprovider =
        Provider.of<TimeInAndOutProvider>(context, listen: false);

    await checkRegisteredIn(
        userCredential.id, formattedDate, timeinandoutprovider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: loading
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(
                    backgroundColor: Color.fromARGB(255, 221, 219, 219),
                    color: Color.fromARGB(255, 0, 173, 238),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 50, left: 30, right: 30, bottom: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  // changes position of shadow
                                ),
                              ],
                              color: const Color.fromARGB(255, 234, 246, 255),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          // color: Colors.white,

                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 40, right: 20, left: 20, bottom: 20),
                                child: Text(
                                  "EMP-ACCESS",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 173, 238),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 24),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Welcome back.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22),
                                    )),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Enter personal PF or email. Ensure to use the same device you registered with.',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  controller: _emailField,
                                  decoration: InputDecoration(
                                      errorText:
                                          errorText.isEmpty ? null : errorText,
                                      floatingLabelStyle:
                                          const TextStyle(color: Colors.black),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 0, 173, 238))),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 0, 173, 238))),
                                      label: const Text('Input PF or Email'),
                                      labelStyle:
                                          const TextStyle(color: Colors.black)
                                      // icon: Icon(Icons.lock),
                                      ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255,
                                            0,
                                            173,
                                            238), // Change the text color here
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Optional: Customize the button's shape
                                        ),
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          loading = true;
                                        });

                                        var answer =
                                            await loginPF(_emailField.text);

                                        if (answer == false) {
                                          setState(() {
                                            errorText = answer;
                                            loading = false;
                                          });
                                        } else if (answer ==
                                                'User with that PF doesnt exist' ||
                                            answer ==
                                                'Some error occurred during login' ||
                                            answer == "Provide PF or email") {
                                          setState(() {
                                            errorText = answer;
                                            loading = false;
                                          });
                                        } else if (answer is Object) {
                                          /// get the data of the answer which is the response with the user data
                                          /// and then add it to the user provider
                                          var responseData =
                                              jsonDecode(answer as String);
                                          var trueUserData =
                                              responseData['data'];

                                          User userCredential =
                                              User.fromMap(trueUserData);
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .addUser(userCredential);

                                          /// get the current userId and date so that you can check the date and
                                          /// check whether the user has already clocked out.
                                          var userID =
                                              Provider.of<UserProvider>(context,
                                                      listen: false)
                                                  .getUser!;
                                          var timeinandout =
                                              Provider.of<TimeInAndOutProvider>(
                                                  context,
                                                  listen: false);
                                          DateTime currentDate = DateTime.now();
                                          String formattedDate =
                                              DateFormat('d-MM-yyyy')
                                                  .format(currentDate);

                                          /// here we are checking whether the user checked in and out
                                          /// where the time of in and out are then stored to show the user on the
                                          /// yes/home page
                                          bool result =
                                              await checkRegisteredOut(
                                                  userID.id,
                                                  formattedDate,
                                                  timeinandout);
                                          await checkRegisteredIn(userID.id,
                                              formattedDate, timeinandout);

                                          /// if the user has already clocked out then take them to the home/yes page
                                          /// otherwise take them to the clockin page so that they can clock out.
                                          if (result == true) {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Yes()),
                                                ((route) => false));
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Clockin()));
                                          }
                                        } else {
                                          setState(() {
                                            errorText = 'Submit failed';
                                            loading = false;
                                          });
                                        }
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(13),
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      )),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(15.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Dont have an account?"),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupPage()));
                                },
                                child: const Text("Register",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 173, 238),
                                        fontSize: 15))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
