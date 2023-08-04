import 'dart:async';

import 'package:attendance/widgets/yes.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class OTPInputAuto extends StatefulWidget {
  final String id;
  const OTPInputAuto({super.key, required this.id});

  @override
  State<OTPInputAuto> createState() => _OTPInputAutoState();
}

class _OTPInputAutoState extends State<OTPInputAuto> {
  final int _otpCodeLength = 6;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
    _startListeningSms();
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.green),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  /// get signature code
  _getSignatureCode() async {
    print("attempting to get the app signature");
    String? signature = await SmsVerification.getAppSignature();
    print("signature $signature");
  }

  /// listen sms
  _startListeningSms() {
    print('i have started listing to the sms message');

    SmsVerification.startListeningSms().then((message) {
              print('this is promising');

      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        textEditingController.text = _otpCode;
        _onOtpCallBack(_otpCode, true);
      });
    });
  }

  _onSubmitOtp() {
    print('auto retrieval has jam');
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode(_otpCode);
    });
  }

  _onClickRetry() {
    _startListeningSms();
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      _otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        print('here the code was autofilled');
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode(otpCode);
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        print('here the code wasnt autofilled');

        _enableButton = true;
        _isLoadingButton = false;
      } else {
        print('no idea what happened here');
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode(code) {
    FirebaseAuth auth = FirebaseAuth.instance;

    FocusScope.of(context).requestFocus(FocusNode());
    Timer(const Duration(milliseconds: 4000), () async {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.id, smsCode: code);

      // Sign the user in (or link) with the credential
      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      if (userCredential.user == null) {
        print('there was an error');
      } else {
        print('yessssssssssssssssssssssssssssssssssssssss');
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Yes()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Input OTP'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFieldPin(
                  textController: textEditingController,
                  autoFocus: true,
                  codeLength: _otpCodeLength,
                  alignment: MainAxisAlignment.center,
                  defaultBoxSize: 46.0,
                  margin: 10,
                  selectedBoxSize: 46.0,
                  textStyle: const TextStyle(fontSize: 16),
                  defaultDecoration: _pinPutDecoration.copyWith(
                      border: Border.all(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.6))),
                  selectedDecoration: _pinPutDecoration,
                  onChange: (code) {
                    _onOtpCallBack(code, false);
                  }),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: MaterialButton(
                    onPressed: _enableButton ? _onSubmitOtp : null,
                    color: Colors.green,
                    disabledColor: const Color.fromARGB(255, 192, 230, 193),
                    child: _setUpButtonChild(),
                  ),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: TextButton(
                  onPressed: _onClickRetry,
                  child: const Text(
                    "Retry",
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return const SizedBox(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return const Text(
        "Verify",
        style: TextStyle(color: Colors.white),
      );
    }
  }
}
