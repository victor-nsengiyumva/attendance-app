import 'package:attendance/providers/error.clockpageProvider.dart';
import 'package:attendance/providers/location.provider.dart';
import 'package:attendance/providers/timeInAndOut.provider.dart';
import 'package:attendance/providers/timeNow.provider.dart';
import 'package:attendance/providers/user.provider.dart';
import 'package:attendance/widgets/clocking.page.dart';
import 'package:attendance/widgets/location.dart';
import 'package:attendance/widgets/phone.login.dart';
import 'package:attendance/widgets/phone.signup.dart';
import 'package:attendance/widgets/test.deviceinfo.dart';
import 'package:attendance/widgets/yes.page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async  {
  
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    MultiProvider(
    providers :[
      ChangeNotifierProvider(create: (context) => LocationProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => ErrorProvider()),
      ChangeNotifierProvider(create: (context) => TimeProvider()),
      ChangeNotifierProvider(create: (context) => TimeInAndOutProvider()),

    ],
    child: const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const Location(),
    );
  }
}



