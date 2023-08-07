import 'package:flutter/material.dart';

class PhoneSignupPage extends StatefulWidget {
  const PhoneSignupPage({super.key});

  @override
  State<PhoneSignupPage> createState() => _PhoneSignupPageState();
}

class _PhoneSignupPageState extends State<PhoneSignupPage> {

  String _selectedVal='';
  _PhoneSignupPageState() {
    _selectedVal = 'Head Office';
  }

  final _branchList = ['Wandegeya Branch', 'Head Office', 'Busega Branch',];
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();

  bool loading = false;

  bool passwordvisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Register',
            style: TextStyle(color: Colors.black, fontSize: 23),
          ),
          leading: IconButton(
              color: Colors.black,
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back)),
        ),
        backgroundColor: Colors.white,
        body: loading
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  color: Color.fromARGB(255, 0, 173, 238),
                ),
              )
            : SingleChildScrollView(
                child: Center(
                    child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 20, bottom: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                            color: Color.fromARGB(255, 234, 246, 255),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        // color: Colorshite,

                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 40, right: 20, left: 20, bottom: 30),
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
                                      'Your account is linked to this device once you registar. You wont be able to clock in on another device.',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.red),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  controller: _firstname,
                                  decoration: InputDecoration(
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
                                      // border: OutlineInputBorder(
                                      //   //borderRadius: BorderRadius.circular(60)
                                      // ),
                                      label: const Text('PF'),
                                      labelStyle:
                                          const TextStyle(color: Colors.black)
                                      //hintText: 'username',

                                      ),
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  controller: _lastname,
                                  decoration: InputDecoration(
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
                                      // border: OutlineInputBorder(
                                      //   //borderRadius: BorderRadius.circular(60)
                                      // ),
                                      label: const Text('Email'),
                                      labelStyle:
                                          const TextStyle(color: Colors.black)
                                      //hintText: 'Email',

                                      ),
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  controller: _email,
                                  decoration: InputDecoration(
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
                                      // border: OutlineInputBorder(
                                      //   //borderRadius: BorderRadius.circular(60)
                                      // ),
                                      label: const Text('Phone Number'),
                                      hintText: 'eg. +25698765432',
                                      labelStyle:
                                          const TextStyle(color: Colors.black)),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: DropdownButtonFormField(
                                    value: _selectedVal,
                                    items: _branchList
                                        .map((e) => DropdownMenuItem(
                                            value: e, child: Text(e)))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedVal = val as String;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: Color.fromARGB(255, 0, 173, 238),
                                    ),
                                    dropdownColor:
                                        Color.fromARGB(255, 234, 246, 255),
                                    decoration:
                                        InputDecoration(label: Text('Branch')),
                                  )),
                              // Padding(
                              //   padding: const EdgeInsets.all(17.0),
                              //   child: TextField(
                              //     style: const TextStyle(color: Colors.black),
                              //     controller: _password,
                              //     decoration: InputDecoration(
                              //       focusedBorder: const OutlineInputBorder(
                              //           borderSide:
                              //               BorderSide(color: Color.fromARGB(
                              //                     255, 0, 173, 238))),
                              //       border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.circular(6),
                              //           borderSide: const BorderSide(
                              //               color: Color.fromARGB(
                              //                     255, 0, 173, 238))),
                              //       // border: OutlineInputBorder(
                              //       //   //borderRadius: BorderRadius.circular(60)
                              //       // ),
                              //       label: const Text('Branch'),
                              //       labelStyle:
                              //           const TextStyle(color: Colors.black),
                              //     ),
                              //     keyboardType: TextInputType.emailAddress,
                              //   ),
                              // ),
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
                                      onPressed: () async {},
                                      child: const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
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
                      ),
                    ]),
              ))));
  }
}
