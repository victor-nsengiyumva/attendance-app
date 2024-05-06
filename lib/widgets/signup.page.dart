import 'package:attendance/backend.api/signUp.dart';
import 'package:attendance/widgets/login.page.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  /// these are the variables for this widget
  String _selectedVal = '';
  String _deviceID = '';
  bool loading = false;
  bool passwordvisible = false;

  /// this constructor of the _PhoneSignupPageState sets the initial value of the _selectedVal
  _SignupPageState() {
    _selectedVal = '';
  }

  /// this iniistate of this widget gets the device information which will later be stored in the database
  /// together with your profile such that you can only login with this device.
  @override
  void initState() {
    super.initState();
    _checkDevice();
  }

  /// this is the function that gets the deviceID which is stored in the database together with your profile
  _checkDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    setState(() {
      _deviceID = androidInfo.id;
    });
  }

  /// this is the list of the items in the dropdown menu for the branches field
  /// where you select the branch that you beling to.
  final _branchList = [
    '',
    'Wandegeya Branch',
    'Head Office',
    'Busega Branch',
    'Test'
  ];

  /// these are the controllers for the fields in the signup form
  final TextEditingController _PF = TextEditingController();
  final TextEditingController _phone_number = TextEditingController();
  final TextEditingController _email = TextEditingController();

  /// these variables are used to check whether the fields in this widget are empty and an error is returned if
  /// they are empty
  String _pfExist = '';
  String _emailEmpty = '';
  String _phoneEmpty = '';
  String _selectedValEmpty = '';

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
                  backgroundColor: Color.fromARGB(255, 209, 208, 208),
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
                                    top: 20, right: 20, left: 20, bottom: 20),
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
                                      'Your account is linked to this device once you registar. You wont be able to clock in on another device.',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.red),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  controller: _PF,
                                  decoration: InputDecoration(
                                      errorText:
                                          _pfExist.isEmpty ? null : _pfExist,
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
                                  controller: _email,
                                  decoration: InputDecoration(
                                      errorText: _emailEmpty.isEmpty
                                          ? null
                                          : _emailEmpty,
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
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  controller: _phone_number,
                                  decoration: InputDecoration(
                                      errorText: _phoneEmpty.isEmpty
                                          ? null
                                          : _phoneEmpty,
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
                                    decoration: InputDecoration(
                                        errorText: _selectedValEmpty.isEmpty
                                            ? null
                                            : _selectedValEmpty,
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
                                        label: Text(
                                          'Branch',
                                          style: TextStyle(fontSize: 19),
                                        )),
                                  )),
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

                                        if (_PF.text.isEmpty) {
                                          setState(() {
                                            _pfExist = 'Field cannot be empty';
                                            loading = false;
                                          });
                                        } else if (_email.text.isEmpty) {
                                          setState(() {
                                            _emailEmpty =
                                                'Field cannot be empty';
                                            loading = false;
                                          });
                                        } else if (_phone_number.text.isEmpty) {
                                          setState(() {
                                            _phoneEmpty =
                                                'Field cannot be empty';
                                            loading = false;
                                          });
                                        } else if (_selectedVal.isEmpty) {
                                          setState(() {
                                            _selectedValEmpty =
                                                'Please select a branch';
                                            loading = false;
                                          });
                                        } else {
                                          var response = await signup(
                                              _PF.text
                                                  .trim(), // this removes any leading or trailing white spaces to ease login with pf
                                              _email.text,
                                              _phone_number.text,
                                              _selectedVal,
                                              _deviceID);

                                          if (response ==
                                              'User with that PF already exists') {
                                            setState(() {
                                              _pfExist = response;
                                              loading = false;
                                            });
                                          } else if (response is Object) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()));
                                          } else {
                                            setState(() {
                                              _pfExist = response;
                                              loading = false;
                                            });
                                          }
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
                      ),
                    ]),
              ))));
  }
}
