import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "dart:io";
import "package:intl/intl.dart";

class AdaptatitveDatePicker extends StatelessWidget {
  final DateTime selectedDate;

  final Function (DateTime) onDateChange;

  const AdaptatitveDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
  });

  @override
  Widget build(BuildContext context) {

    _showDatePicker(BuildContext context) {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2019),
              lastDate: DateTime.now())
          .then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        onDateChange (pickedDate);
      });
    }

    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChange,
            ),
          )
        : Container(
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => _showDatePicker(context),
                  child: Icon(Icons.date_range),
                ),
                Container(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Data",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                            "Data: ${DateFormat("d/M/y").format(selectedDate)}"),
                      ],
                    ))
              ],
            ),
          );
  }
}
