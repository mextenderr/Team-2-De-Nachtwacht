import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/data.dart';
import 'package:provider/provider.dart';
import 'constants.dart' as constants;

Widget sample3(BuildContext context) {
  final fromDate = DateTime(2019, 05, 22);
  final toDate = DateTime.now();



return Consumer<Data>(
  builder: (context, data, child) {
    var points  = data.data.map((point){
              DataPoint<DateTime>(value: point["value"], xAxis: point["time"]);
            }).toList();
    return Center(
    child: Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: BezierChart(
        fromDate: fromDate,
        bezierChartScale: BezierChartScale.HOURLY,
        toDate: toDate,
        selectedDate: toDate,
        series: [
          BezierLine(
            lineColor: constants.COLOR,
            label: "BPM",
            onMissingValue: (dateTime) {
              if (dateTime.day.isEven) {
                return 10.0;
              }
              return 5.0;
            },
            data: points,
          ),
        ],
        config: BezierChartConfig(
          xAxisTextStyle: TextStyle(color: constants.COLOR, fontSize: 10),
          verticalIndicatorStrokeWidth: 3.0,
          verticalIndicatorColor: Colors.black26,
          showVerticalIndicator: true,
          verticalIndicatorFixedPosition: false,
          backgroundColor: Colors.transparent,
          footerHeight: 30.0,
        ),
      ),
    ),
  );
  },
);
  
}