import 'package:flutter/material.dart';


class PhoneSignupPage extends StatefulWidget {
  const PhoneSignupPage({super.key});

  @override
  State<PhoneSignupPage> createState() => _PhoneSignupPageState();
}

class _PhoneSignupPageState extends State<PhoneSignupPage> {
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool loading = false;
  

  bool passwordvisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:Text('Register'),
        leading: IconButton(
            color:Colors.black,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.white,
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.green,
              ),
            )
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 60, bottom: 20),
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
                            color: Color(0xFFF3FAF3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        // color: Colorshite,

                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  controller: _firstname,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: BorderSide(color: Colors.green)),
                                      // border: OutlineInputBorder(
                                      //   //borderRadius: BorderRadius.circular(60)
                                      // ),
                                      label: Text('PF'),
                                        labelStyle: TextStyle(color: Colors.black)
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
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: BorderSide(color: Colors.green)),
                                      // border: OutlineInputBorder(
                                      //   //borderRadius: BorderRadius.circular(60)
                                      // ),
                                      label: Text('Email'),
                                        labelStyle: TextStyle(color: Colors.black)
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
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: BorderSide(color: Colors.green)),
                                      // border: OutlineInputBorder(
                                      //   //borderRadius: BorderRadius.circular(60)
                                      // ),
                                      label: Text('Phone Number'),
                                      hintText: 'eg. +25698765432',
                                        labelStyle: TextStyle(color: Colors.black)),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  controller: _password,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: BorderSide(color: Colors.green)),
                                      // border: OutlineInputBorder(
                                      //   //borderRadius: BorderRadius.circular(60)
                                      // ),
                                      label: Text('Branch'),
                                        labelStyle: TextStyle(color: Colors.black),
                                      ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors
                                            .green, // Change the text color here
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Optional: Customize the button's shape
                                        ),
                                        // padding: EdgeInsets.symmetric(
                                        //     horizontal: 16,
                                        //     vertical:
                                        //         8), // Optional: Adjust the button's padding
                                      ),
                                      onPressed: () async {
                                        // setState(() {
                                        //   loading = true;
                                        // });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text('Submit'),
                                      )),
                              ),
                              
                                            const Padding(
                                              padding: EdgeInsets.all(15.0),
                                              
                                            ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
