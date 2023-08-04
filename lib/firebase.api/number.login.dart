import 'package:attendance/widgets/OTP.input.dart';
import 'package:attendance/widgets/phone.login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



phoneLogin(String number, BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;


  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: number,
    verificationCompleted: (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
      print('auto login happened');
    },
    verificationFailed: (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const PhoneLoginPage()));
      }
    },
    codeSent: (String verificationId, int? resendToken) async {
      print('Entering here');
      // Update the UI - wait for the user to enter the SMS code

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OTPInputAuto (
                    id: verificationId,
                  )));
    },
    timeout: const Duration(seconds: 60),
    codeAutoRetrievalTimeout: (String verificationId) {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => PhoneLoginPage()));
      print('60 seconds have elapsed');
    },
  );
}
