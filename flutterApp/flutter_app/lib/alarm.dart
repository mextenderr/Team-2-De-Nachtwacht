//import 'dart:html';
//import 'dart:typed_data';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
//import 'dart:async';
//import 'dart:io';
//import 'package:flutter/services.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audio_cache.dart';
import 'soundselect.dart';
//import 'package:audioplayers/audioplayers.dart';

class Alarm extends StatefulWidget {
  
  const Alarm({Key key,}) : super(key: key);

  @override
  AlarmState createState() => AlarmState();
  
}

class AlarmState extends State<Alarm> {
  int selectedSong;

  void _toSoundselectPage()  async{
    final int selectedSound = await Navigator.push(context,  MaterialPageRoute(builder: (context) => Soundselect()),);
    setState(() {
      selectedSong = selectedSound;
    });
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

              if( selectedSong == 1)
              {
                const alarmAudioPath = "meadowlark.mp3";
                audioCache.play(alarmAudioPath);
              }

              else if(selectedSong == 2)
              {
                const alarmAudioPath = "alarmsound1.mp3";
                audioCache.play(alarmAudioPath);
              }
              else 
              {
                //const alarmAudioPath = "alarmsound1.mp3";
                //audioCache.play(alarmAudioPath);
              }
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
