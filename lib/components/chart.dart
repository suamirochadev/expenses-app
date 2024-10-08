// ignore_for_file: avoid_print

import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransactions});

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final startOfWeek = normalizedToday.subtract(Duration(days: today.weekday - 1));
    
    return List.generate(7, (index) {
      final weekDay = startOfWeek.add(Duration(days: index)
      
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'value': totalSum,
      };
    }).toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, transaction) {
      return sum + (transaction['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(8),
      child: Row(
        children: groupedTransactions.map((data) {
          return Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChartBar(
                label: data['day'].toString(),
                value: double.parse(data['value'].toString()),
                percentage: _weekTotalValue == 0
                    ? 0
                    : (data['value'] as double) / _weekTotalValue,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
