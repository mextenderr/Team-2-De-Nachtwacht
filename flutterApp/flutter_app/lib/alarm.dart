//import 'dart:html';
//import 'dart:typed_data';
import 'package:flutter/material.dart';
//import 'dart:async';
//import 'dart:io';
//import 'package:flutter/services.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audio_cache.dart';
//import 'package:audioplayers/audioplayers.dart';

class Alarm extends StatefulWidget{
      
  
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AlarmState();
  }
  
}

class AlarmState extends State{
  static AudioCache player = new AudioCache();

 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     
    return Scaffold(
      appBar: AppBar(
        title:  Text("alarm"),
      ),
      body: Center(
        child : Column(
                  children<Widget>:[
                  FloatingActionButton(
                  onPressed:() {
                  const alarmAudioPath = "alarmsound1.mp3";
                  player.play(alarmAudioPath);
                  },
                  Text(
                  'Click for sound',
                  textAlign: TextAlign.center,
          ),
          ),]
        ),
        
        
        
      )
      
    );
  }
  
} 
