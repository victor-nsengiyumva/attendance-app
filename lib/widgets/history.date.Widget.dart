import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatefulWidget {
 final String date;
 const DateWidget({super.key, required this.date});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  String _getDay() {
    // Convert the date string to a DateTime object
    DateTime date = DateFormat("dd-MM-yyyy").parse(widget.date);

    // Format the date to get just the day
    String day = DateFormat("E").format(date);
    return day;
  }

  String _getDate() {
    DateTime date = DateFormat("dd-MM-yyyy").parse(widget.date);

    // Format the date to get just the day
    String day = DateFormat("dd").format(date);
    return day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 173, 238),
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5, bottom: 5),
          child: Column(
            children: [
              Text(
                _getDay(),
                style: TextStyle(color: Colors.white,fontSize: 13),
              ),
              Text(
                _getDate(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
