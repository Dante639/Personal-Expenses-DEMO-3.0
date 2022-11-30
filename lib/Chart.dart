import 'package:first_app/ChartBar.dart';
import 'package:first_app/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Chart extends StatelessWidget {
  final List<Transaction> recentTransacTions;

  const Chart(this.recentTransacTions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransacTions.length; i++) {
        if (recentTransacTions[i].date.day == weekDay.day &&
            recentTransacTions[i].date.month == weekDay.month &&
            recentTransacTions[i].date.year == weekDay.year) {
          totalSum += recentTransacTions[i].total;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as num);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                (data['day'] as String),
                (data['amount'] as double),
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}