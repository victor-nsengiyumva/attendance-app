import 'package:attendance/widgets/history.date.Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../backend.api/userCheckins.dart';
import '../backend.api/userCheckouts.dart';
import '../coreFunctions/dateLogs.function.dart';
import '../providers/dateLogsProvider.dart';
import '../providers/user.provider.dart';
import '../providers/userCheckinsandCheckouts.provider.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
    var dateList = Provider.of<DateLogsModelProvider>(context, listen: false)
        .getdateLogsList;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Attendance",
          style: TextStyle(
              color: Colors.black, fontSize: 21, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      bottom:
                          BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
                      top:
                          BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
                      left:
                          BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
                      right:
                          BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Color.fromARGB(255, 150, 150, 150),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: const Color.fromARGB(255, 0, 173, 238),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "August 2023",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 173, 238),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromARGB(255, 150, 150, 150),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      bottom:
                          BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
                      top:
                          BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
                      left:
                          BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
                      right:
                          BorderSide(color: Color.fromARGB(255, 221, 221, 221)),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              "Date",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          )),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                              child: Center(
                                  child: Text(
                            "Check In",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ))),
                          Expanded(
                              child: Center(
                                  child: Text(
                            "Check Out",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ))),
                        ],
                      ),
                      
                      ...dateList.map((e) => Column(
                        children: [
                          Divider(
                            thickness: 1.1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10,top:10),
                            child: Row(
                              children: [
                                Center(child: DateWidget(date: e.date)),
                                SizedBox(
                                  width: 40,
                                ),
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  e.checkinTime,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ))),
                                Expanded(
                                    child: Center(
                                        child: Text(e.checkoutTime,
                                            style: TextStyle(
                                              fontSize: 15,
                                            )))),
                              ],
                            ),
                          ),
                          
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
