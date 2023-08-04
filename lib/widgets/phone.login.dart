import 'dart:convert';
import 'package:attendance/backend.api/login.dart';
import 'package:attendance/firebase.api/number.login.dart';
import 'package:attendance/widgets/phone.signup.dart';
import 'package:flutter/material.dart';


class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  String errorText = '';
  bool loading = false;
  bool passwordvisible = false;

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
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Verifying Phone Number')
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
                        Image.asset('assets/images/logo.png'),
                        const SizedBox(
                          height:20

                        ),
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
                                padding: EdgeInsets.only(top: 60,right: 20,left: 20,bottom: 30),
                                child: Text(
                                  "APP-NAME",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 24),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                    child: Text(
                                  'Welcome back.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 22),
                                )),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                    child: Text(
                                  'Enter personal PF or email. Ensure to use the same device you registered with.',
                                  style: TextStyle(
                                       fontSize: 15,color: Colors.grey),
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
                                          borderSide:
                                              const BorderSide(color: Colors.green)),
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
                                          var responseData =
                                              jsonDecode(answer as String);
                                          var contact = responseData['data']
                                              ['mobile_number'];
                                                              
                                          await phoneLogin(contact, context);
                                        } else {
                                          setState(() {
                                            errorText = 'Submit failed';
                                            loading = false;
                                          });
                                        }
                                      },
                                      child:  const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Text('Submit',style: TextStyle(
                                          fontWeight: FontWeight.bold,fontSize: 17
                                        ),),
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
                                              const PhoneSignupPage()));
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
