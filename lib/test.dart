import 'package:attendance/backend.api/userCheckins.dart';
import 'package:attendance/providers/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
    var userID = Provider.of<UserProvider>(context, listen: false).getUser!.id;
    userCheckins(userID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("This is a test page")),
    );
  }
}
