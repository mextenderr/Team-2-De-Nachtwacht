import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/alarm.dart';
import 'package:flutter_app/models/audioManager.dart';
import 'package:flutter_app/models/data.dart';
import 'package:flutter_app/pages/alarmPage.dart';
import 'package:flutter_app/pages/bluetoothPage.dart';
import 'package:flutter_app/chart.dart';
import 'package:flutter_app/helpers/LinePath.dart';
import 'package:flutter_app/models/user.dart';
import 'package:provider/provider.dart';
import '../constants.dart' as constants;
import 'alarmPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool waiting = false;
  int count = 0;
  AudioManager audioManager = AudioManager();

  void _stopAlarm() {
    audioManager.stop();
    setState(() {});
  }

  Widget stopAlarmButton() {
    return Consumer<Alarm>(builder: (context, alarm, child) {
      print("notified!");
      if (alarm.playing) {
       
        return(Container(
        
          child:  OutlineButton(
                onPressed: () {
                  _stopAlarm();
                },
                color: Colors.transparent,
                borderSide: BorderSide(color: Colors.redAccent),
                child:
                    Row(
                      mainAxisAlignment: 
                      MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.alarm_off, color: Colors.redAccent),
                        Text("Stop alarm", style: TextStyle(color: Colors.redAccent)),
                      ],
                    )))
        );
      
      } else {
        return Container(width: 0, height: 0);
      }
    });
  }

  void _toBluetoothPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BluetoothPage()),
    );
  }

  void _toAlarmPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlarmPage()),
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  String titleString() {
    User user = User();
    String name = capitalize(user.name);
    DateTime time = DateTime.now();
    var hour = time.hour;
    print(hour);
    String daypart;
    if (hour <= 6) {
      daypart = "nacht";
    } else if (hour >= 6 && hour < 12) {
      daypart = "morgen";
    } else if (hour >= 12 && hour < 18) {
      daypart = "middag";
    } else if (hour >= 18) {
      daypart = "avond";
    }

    return "Goede$daypart, $name!";
  }

  Widget chart(){
    
  final fromDate = DateTime(2019, 05, 22);
  final toDate = DateTime.now();


{
    var points  = [
              DataPoint<DateTime>(value: 10, xAxis: DateTime.now())
    ];
    return Center(
    child: Container(
      color: Colors.transparent,
     
      height: 350,
      
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
  
}}
  

  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipPath(
              clipper: LinePathSmall(),
              child: Container(
                color: Color.fromRGBO(65, 64, 66, 1),
                height: 80,
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(titleString(),
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: constants.COLOR)),
          ),
          Center(
              child: Stack(
            children: <Widget>[
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Icon(
                  Icons.favorite,
                  color: Colors.grey[100],
                  size: 230,
                ),
              )),
              chart(),
            ],
          )),
          Expanded(
                      child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    stopAlarmButton(),
                    OutlineButton(
                      onPressed: () {
                        _toAlarmPage();
                      },
                      color: Colors.transparent,
                      borderSide: BorderSide(
                        color: Color.fromRGBO(110, 198, 186, 1),
                        width: 1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.alarm,
                            color: constants.COLOR,
                          ),
                          Text("Alarm",
                              style: TextStyle(
                                  color: Color.fromRGBO(110, 198, 186, 1))),
                        ],
                      ),
                    ),
                    OutlineButton(
                      onPressed: () {
                        _toBluetoothPage();
                      },
                      color: Colors.transparent,
                      borderSide: BorderSide(
                        color: Color.fromRGBO(110, 198, 186, 1),
                        width: 1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.bluetooth,
                            color: constants.COLOR,
                          ),
                          Text("Armband connectie",
                              style: TextStyle(
                                  color: Color.fromRGBO(110, 198, 186, 1))),
                        ],
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
