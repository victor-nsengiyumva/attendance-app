import 'package:attendance/backend.api/userCheckins.dart';
import 'package:attendance/coreFunctions/dateLogs.function.dart';
import 'package:attendance/providers/dateLogsProvider.dart';
import 'package:attendance/providers/user.provider.dart';
import 'package:attendance/providers/userCheckinsandCheckouts.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import 'backend.api/userCheckouts.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    var userID = Provider.of<UserProvider>(context, listen: false).getUser!.id;
    var checkinsAndoutsProvider =
        Provider.of<CheckinsAndoutsProvider>(context, listen: false);
    await userCheckins(userID, checkinsAndoutsProvider);
    await userCheckouts(userID, checkinsAndoutsProvider);
    getDateLogs(context);
  }

  @override
  Widget build(BuildContext context) {
        var dateList = Provider.of<DateLogsModelProvider>(context, listen: false).getdateLogsList;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child:
          ListView(
            children: [
              Row(
                children: [
                  Expanded(child: Center(child: Text("Date"))),
                  Expanded(child: Center(child: Text("Check In"))),
                  Expanded(child: Center(child: Text("Check Out"))),
                ],
              ),
              SizedBox(height: 20,),
              ...dateList.map((e) => Row(
                children: [
                  Expanded(child: Center(child: Text(e.date))),
                  Expanded(child: Center(child: Text(e.checkinTime))),
                  Expanded(child: Center(child: Text(e.checkoutTime))),
                ],
              ))
            ],
          )
        ),
      ),
    );
  }
}
