import 'package:flor_de_gato/Controllers/request_controller.dart';
import 'package:flor_de_gato/models/month_value.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:provider/provider.dart";

class Card6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SfCartesianChart(

        primaryXAxis: CategoryAxis(
          interval: 1,
          labelRotation: 30,
        ),
        tooltipBehavior: TooltipBehavior(enable: false),
        series: <LineSeries<dynamic, String>>[
          LineSeries<MonthValue, String>(
            sortingOrder: SortingOrder.descending,
            dataSource: context.watch<RequestController>().monthValues,
            xValueMapper: (MonthValue sales, _) => sales.month,
            yValueMapper: (MonthValue sales, _) => sales.value,
            color: Color(0xFF442C2E),
          ),
        ],
      ),
      color: Color(0xFFFEEAE6),
      elevation: 5,
    );
  }
}