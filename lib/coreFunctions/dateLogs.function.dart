
import 'package:attendance/providers/dateLogsProvider.dart';
import 'package:attendance/providers/userCheckinsandCheckouts.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dateLogs.model.dart';

getDateLogs(BuildContext context) {
  List<String> dateList = [];
  var dateLogsModelProvider =
      Provider.of<DateLogsModelProvider>(context, listen: false);
  var checkoutsList =
      Provider.of<CheckinsAndoutsProvider>(context, listen: false).getcheckouts;
  var checkinsList =
      Provider.of<CheckinsAndoutsProvider>(context, listen: false).getcheckins;
  for (Map<String, dynamic> value in checkinsList) {
    dateList.add(value["dateToday"]);
  }
  for (Map<String, dynamic> value in checkoutsList) {
    dateList.add(value["dateToday"]);
  }

  for (String date in dateList) {
    String checkin = "- -:- -";
    String checkout = "- -:- -";

    for (var item in checkinsList) {
      if (item["dateToday"] == date) {
        checkin = item["checkInTime"];
      }
    }
    for (var item in checkoutsList) {
      if (item["dateToday"] == date) {
        checkout = item["checkOutTime"];
      }
    }

    DateLogsModel newModel =
        DateLogsModel(date: date, checkinTime: checkin, checkoutTime: checkout);

    dateLogsModelProvider.updateList(newModel);
  }
}
