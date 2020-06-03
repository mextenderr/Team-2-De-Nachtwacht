import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';
//import 'package:fl_chart/fl_chart.dart';
//import 'package:bezier_chart/bezier_chart.dart';
import 'package:fcharts/fcharts.dart';

import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChartState();
  }
}

class ChartState extends State {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  List data1 = new List();
  void initData() async {
    data1 = await getData();
    setState(() {
      data1 = data1;

    });
  }

  List <List<String>> value(){
    final List <List<String>> valuee = [];
    for (int i = 0; i < 5; i++) {
     valuee.add([data1[i]["id"].toString(), data1[i]["name"]]);
    }
    return valuee;
  }




// X value -> Y value
  final myData = [
    ["x", "1"],
    ["B", "❓"],
    ["C", "✖"],
    ["D", "❓"],
    ["E", "✖"],
    ["F", "✖"],
    ["G", "✔"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LineChart(
      lines: [
        new Line<List<String>, String, String>(
          data: value(),
//          [
//            [data1[1]["id"].toString(), "1"],
//            ["B", "❓"],
//            ["C", "✖"],
//            ["D", "❓"],
//            ["E", "✖"],
//            ["F", "✖"],
//            ["G", "✔"],
//          ],
          xFn: (datum) => datum[0],
          yFn: (datum) => datum[1],
        ),
      ],
      chartPadding: new EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 30.0),
    ));
  }

  Future<List> getData() async {
    // String url = "http://www.localhost/projectd/slaapdata1";
    String url = "https://jsonplaceholder.typicode.com/comments";
    http.Response r = await http.get(url);
    List data = json.decode(r.body);
    return data;
  }
}
