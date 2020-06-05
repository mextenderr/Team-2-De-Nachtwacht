import 'package:flutter/material.dart';
import 'package:flutter_app/pages/alarmPage.dart';
import 'package:audioplayers/audio_cache.dart';

class Soundselect extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SoundselectState();
  }
  
  
}

class SoundselectState extends State{
  int mp3soundselect;
  
  void _toAlarmPage(song) {
    Navigator.pop(context, song);

  }


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
              _toAlarmPage(1);
            },
            child: Text(
              'Birds chirping',
              textAlign: TextAlign.center,
            ),
          ),
          FlatButton(
            onPressed: () {
              _toAlarmPage(2);
            },
            child: Text(
              'Whale',
              textAlign: TextAlign.center,
            ),
          ),
          FlatButton(
            onPressed: (){
                _toAlarmPage(3);
            },
            child: Text(
              'Waterfall',
              textAlign: TextAlign.center,
              ),
              ),
          FlatButton(
            onPressed: (){
                _toAlarmPage(4);
            },
            child: Text(
              'Crickets',
              textAlign: TextAlign.center,
              ),
              ),
          FlatButton(
            onPressed: (){
                _toAlarmPage(5);
            },
            child: Text(
              'Beachwaves',
              textAlign: TextAlign.center,
              ),
              ),
          FlatButton(
            onPressed: (){
                _toAlarmPage(6);
            },
            child: Text(
              'Healing water',
              textAlign: TextAlign.center,
              ),
              ),
          FlatButton(
            onPressed: (){
                _toAlarmPage(7);
            },
            child: Text(
              'Mild rainstorm',
              textAlign: TextAlign.center,
              ),
              ),
          FlatButton(
            onPressed: (){
                _toAlarmPage(8);
            },
            child: Text(
              'Running creek',
              textAlign: TextAlign.center,
              ),
              ),
          FlatButton(
            onPressed: (){
                _toAlarmPage(9);
            },
            child: Text(
              'Rainforest',
              textAlign: TextAlign.center,
              ),
              ),
          FlatButton(
            onPressed: (){
                _toAlarmPage(10);
            },
            child: Text(
              'NOT an easter egg',
              textAlign: TextAlign.center,
              ),
              ),
            
        ],
      ),
      
    );
  }
  
} 