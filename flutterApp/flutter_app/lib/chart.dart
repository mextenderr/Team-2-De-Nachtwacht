import 'package:flutter/material.dart';
//import 'dart:math';
import 'package:bezier_chart/bezier_chart.dart';
// EXCLUDE_FROM_GALLERY_DOCS_END
//import 'package:charts_flutter/flutter.dart' as charts;
//import 'package:flutter/material.dart';

class Chart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState
    return ChartState();
  }


}


class ChartState extends State{
  @override
//  Widget build(BuildContext context) {
//
//    // TODO: implement build
//    return Scaffold(
//
//      appBar: AppBar(
//        title:  Text("chart")),


//      body: new Material(
//        color: Colors.blue,
//
//        child: Center(
//          child:Text("Hello"),
//
//      ),
//    )

  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
        height: MediaQuery
            .of(context)
            .size
            .height / 2,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: BezierChart(
          bezierChartScale: BezierChartScale.CUSTOM,
          xAxisCustomValues: const [0,1,2, 3,4,5,6,7,8,9,10 ,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,],
          series: const [
            BezierLine(
              label: "Custom 1",
              data: const [
                DataPoint<double>(value: 10, xAxis: 0),
                DataPoint<double>(value: 130, xAxis: 1),
                DataPoint<double>(value: 50, xAxis: 2),
                DataPoint<double>(value: 150, xAxis: 3),
                DataPoint<double>(value: 75, xAxis: 4),
                DataPoint<double>(value: 0, xAxis: 5),
                DataPoint<double>(value: 5, xAxis: 6),
                DataPoint<double>(value: 45, xAxis: 7),
                DataPoint<double>(value: 10, xAxis: 8),
                DataPoint<double>(value: 130, xAxis: 9),
                DataPoint<double>(value: 50, xAxis: 10),
                DataPoint<double>(value: 150, xAxis: 11),
                DataPoint<double>(value: 75, xAxis: 12),
                DataPoint<double>(value: 0, xAxis: 13),
                DataPoint<double>(value: 5, xAxis: 14),
                DataPoint<double>(value: 45, xAxis: 15),
                DataPoint<double>(value: 10, xAxis: 16),
                DataPoint<double>(value: 130, xAxis: 17),
                DataPoint<double>(value: 50, xAxis: 18),
                DataPoint<double>(value: 150, xAxis: 19),
                DataPoint<double>(value: 75, xAxis: 20),
                DataPoint<double>(value: 0, xAxis: 21),
                DataPoint<double>(value: 5, xAxis: 22),
                DataPoint<double>(value: 45, xAxis: 23),
                DataPoint<double>(value: 45, xAxis: 24),
                DataPoint<double>(value: 10, xAxis: 25),
                DataPoint<double>(value: 130, xAxis: 26),
                DataPoint<double>(value: 50, xAxis: 27),
                DataPoint<double>(value: 150, xAxis: 28),
                DataPoint<double>(value: 75, xAxis: 29),
                DataPoint<double>(value: 0, xAxis: 30),

                DataPoint<double>(value: 75, xAxis: 31),
                DataPoint<double>(value: 0, xAxis: 32),
                DataPoint<double>(value: 5, xAxis: 33),
                DataPoint<double>(value: 45, xAxis: 34),
                DataPoint<double>(value: 45, xAxis: 35),
                DataPoint<double>(value: 10, xAxis: 36),
                DataPoint<double>(value: 130, xAxis: 37),
                DataPoint<double>(value: 50, xAxis: 38),
                DataPoint<double>(value: 150, xAxis: 39),
                DataPoint<double>(value: 75, xAxis: 40),
                DataPoint<double>(value: 0, xAxis: 41),

                DataPoint<double>(value: 75, xAxis: 42),
                DataPoint<double>(value: 0, xAxis: 43),
                DataPoint<double>(value: 5, xAxis: 44),
                DataPoint<double>(value: 45, xAxis: 45),
                DataPoint<double>(value: 45, xAxis: 46),
                DataPoint<double>(value: 10, xAxis: 47),
                DataPoint<double>(value: 130, xAxis: 48),
                DataPoint<double>(value: 50, xAxis: 49),
                DataPoint<double>(value: 150, xAxis: 50),
                DataPoint<double>(value: 75, xAxis: 51),
                DataPoint<double>(value: 0, xAxis: 52),
                DataPoint<double>(value: 5, xAxis: 53),
                DataPoint<double>(value: 45, xAxis: 54),
                DataPoint<double>(value: 45, xAxis: 55),
                DataPoint<double>(value: 10, xAxis: 56),
                DataPoint<double>(value: 130, xAxis: 57),
                DataPoint<double>(value: 50, xAxis: 58),
                DataPoint<double>(value: 150, xAxis: 59),
                DataPoint<double>(value: 75, xAxis: 60),
                DataPoint<double>(value: 0, xAxis: 61),
                DataPoint<double>(value: 5, xAxis: 62),
                DataPoint<double>(value: 45, xAxis: 63),
                DataPoint<double>(value: 45, xAxis: 64),
                DataPoint<double>(value: 10, xAxis: 65),
                DataPoint<double>(value: 130, xAxis: 66),
                DataPoint<double>(value: 50, xAxis: 67),
                DataPoint<double>(value: 150, xAxis: 68)

              ],
            ),

          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 2.0,
            verticalIndicatorColor: Colors.black12,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,

            contentWidth: MediaQuery
                .of(context)
                .size
                .width * 3.5,
            backgroundColor: Colors.red,
          ),
        ),
      ),
    );
  }











  }
