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
  final int selectedSong;

  const Alarm({Key key, this.selectedSong}) : super(key: key);

  @override
  AlarmState createState() => AlarmState();
  
}

class AlarmState extends State<Alarm> {

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

              if( widget.selectedSong == 1)
              {
                const alarmAudioPath = "meadowlark.mp3";
                audioCache.play(alarmAudioPath);
              }

              else if(widget.selectedSong == 2)
              {
                const alarmAudioPath = "whale.mp3";
                audioCache.play(alarmAudioPath);
              }
              else if(widget.selectedSong == 3)
              {
                const alarmAudioPath = "waterfall.mp3";
                audioCache.play(alarmAudioPath);
              }
              else if(widget.selectedSong == 4)
              {
                const alarmAudioPath = "crickets.mp3";
                audioCache.play(alarmAudioPath);
              }
              else if(widget.selectedSong == 5)
              {
                const alarmAudioPath = "beachwaves.mp3";
                audioCache.play(alarmAudioPath);
              }
              else if(widget.selectedSong == 6)
              {
                const alarmAudioPath = "healingwater.mp3";
                audioCache.play(alarmAudioPath);
              }
              else if(widget.selectedSong == 7)
              {
                const alarmAudioPath = "rainstorm.mp3";
                audioCache.play(alarmAudioPath);
              }
              else if(widget.selectedSong == 8)
              {
                const alarmAudioPath = "creek.mp3";
                audioCache.play(alarmAudioPath);
              }
              else if(widget.selectedSong == 9)
              {
                const alarmAudioPath = "rainforest.mp3";
                audioCache.play(alarmAudioPath);
              }
              else if(widget.selectedSong == 10)
              {
                const alarmAudioPath = "alarmsound1.mp3";
                audioCache.play(alarmAudioPath);
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
