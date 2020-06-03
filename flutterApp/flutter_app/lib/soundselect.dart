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
  int mp3soundselect;
  
  void _toAlarmPage(song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => 
          new Alarm(selectedSong: song)));

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
              'Coffing meme sound',
              textAlign: TextAlign.center,
            ),
          ),
          FloatingActionButton(
            onPressed: (){
                _toAlarmPage(3);
            },
            child: Text('Confirm Selection'))
        ],
      ),
      
    );
  }
  
} 