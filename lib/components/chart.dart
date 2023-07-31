import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  
  final List<Transaction> recentTransacion;

  const Chart(this.recentTransacion, {super.key});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransacion.length; i++) {
        bool sameDay = recentTransacion[i].date.day == weekDay.day;
        bool sameMonth = recentTransacion[i].date.month == weekDay.month;
        bool sameYear = recentTransacion[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransacion[i].value;
        }
      }
      return {
        'day': DateFormat.E('pt_Br').format(weekDay)[0].toUpperCase(),
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
     return groupedTransactions.fold(0.0, (sum, tr) {
         return sum +  (tr['value'] as double);
     });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.fromLTRB(10, 20, 10, 15),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return 
            Flexible(
            child: ChartBar(
              label: tr['day'].toString(),
              value: tr['value'] as double,
              percentage: _weekTotalValue != 0 ? (tr["value"] as double) / _weekTotalValue : 0,
              ));
          }).toList(),
        ),
      ),
    );
  }
}
