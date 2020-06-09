import 'package:flutter/material.dart';
import 'package:flutter_app/pages/alarmPage.dart';
import 'package:flutter_app/bluetooth.dart';
import 'package:flutter_app/chart.dart';
import 'package:flutter_app/helpers/LinePath.dart';
import 'package:flutter_app/models/user.dart';
import '../constants.dart' as constants;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool waiting = false;



  void _toBluetoothPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Bluetooth()),
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

    return "Goede $daypart, $name!";
  }

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
                Center(child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Icon(Icons.favorite, color: Colors.grey[100], size: 230,),
                )),
                sample3(context),
              ],
            )
          ),
          Center(
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
               
                children: <Widget>[
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
                        Icon(Icons.alarm, color: constants.COLOR,),
                        Text("Alarm",
                            style:
                                TextStyle(color: Color.fromRGBO(110, 198, 186, 1))),
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
                        Icon(Icons.bluetooth, color: constants.COLOR,),
                        Text("Armband connectie",
                            style:
                                TextStyle(color: Color.fromRGBO(110, 198, 186, 1))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}