import 'package:attendance/providers/location.provider.dart';
import 'package:attendance/widgets/clocking.page.dart';
import 'package:attendance/widgets/location.dart';
import 'package:attendance/widgets/phone.login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'widgets/yes.page.dart';

void main() async  {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers :[
      ChangeNotifierProvider(create: (context) => LocationProvider()),

    ],
    child: MyApp(),
  ));
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
      home: Clockin(),
    );
  }
}



