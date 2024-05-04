import 'package:attendance/OTP_code/OTP.input.dart';
import 'package:attendance/widgets/login.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



phoneLogin(String number, BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;


  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: number,
    verificationCompleted: (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    },
    verificationFailed: (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    },
    codeSent: (String verificationId, int? resendToken) async {
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
    },
  );
}
