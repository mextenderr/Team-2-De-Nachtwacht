//import 'dart:html';
//import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
//import 'dart:async';
//import 'dart:io';
//import 'package:flutter/services.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_app/soundselect.dart';
//import 'package:audioplayers/audioplayers.dart';

class Alarm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AlarmState();
  }
}

class AlarmState extends State {
  String mp3;


  String getSong(String mp3){
    print(mp3);
    return mp3;

  }
  void _toSoundselectPage() {
    Navigator.push(context,  MaterialPageRoute(builder: (context) => Soundselect()),);

  }
  

  @override
  Widget build(BuildContext context) {
    AudioPlayer advancedPlayer = new AudioPlayer();
    AudioCache audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    return Scaffold(
      appBar: AppBar(
        title: Text("alarm"),
      ),
      body: ListView(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              const alarmAudioPath = "meadowlark.mp3";
              audioCache.play(alarmAudioPath);
            },
            child: Text(
              'Click for sound',
              textAlign: TextAlign.center,
            ),
          ),
          FlatButton(
            onPressed: (){
              _toSoundselectPage();
            },
            child: Text("Select Sound")
            ),
          FlatButton(
            onPressed: () {
              advancedPlayer.stop();
            },
            child: Text("Geluid stoppen"),
          )
        ],
      ),
    );
  }
}
