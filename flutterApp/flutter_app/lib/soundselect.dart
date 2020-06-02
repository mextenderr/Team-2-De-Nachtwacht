import 'package:flutter/material.dart';
import 'package:flutter_app/alarm.dart';
import 'package:audioplayers/audio_cache.dart';

class Soundselect extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SoundselectState();
  }
  
  
}

class SoundselectState extends State{
 
 
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Sound"),
      ),
      body: ListView(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              AlarmState().getSong("meadowlark.mp3");
            },
            child: Text(
              'Birds chirping',
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
  
} 