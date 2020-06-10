import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_app/track.dart';
import 'package:flutter_app/tracks.dart' as tracks;
import 'package:shared_preferences/shared_preferences.dart';

class AudioManager {
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  Track currentTrack;
  bool alarmPlaying = false;
  var _controller;
  
  AudioManager._privateConstructor() {
    advancedPlayer = new AudioPlayer();
    _controller = StreamController<bool>();
    currentTrack = tracks.tracklist[0];
    audioCache = new AudioCache(fixedPlayer: advancedPlayer, respectSilence: false);
    _loadSavedTrack();
  }

  static final AudioManager _instance = AudioManager._privateConstructor();

 


  factory AudioManager() {
 
    return _instance;
  }

  Stream<bool> get stream =>
    _controller.stream;

    
  void _loadSavedTrack() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkPath = prefs.containsKey('alarmTrackPath');
    bool checkName = prefs.containsKey('alarmTrackName');
    if(checkPath && checkName){
      String name  = prefs.getString('alarmTrackName');
      String path  = prefs.getString('alarmTrackPath');
      
      currentTrack = new Track(name: name, path: path);
    }
  }
  void setTrack(Track track) async{
    currentTrack = track;
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString('alarmTrackPath', track.path);
prefs.setString('alarmTrackName', track.name);

  }

  void stop(){
    advancedPlayer.stop();
    alarmPlaying = false;
    _controller.sink.add(alarmPlaying);
  }

  void play(){
    audioCache.play(currentTrack.path);
    alarmPlaying = true;
  _controller.sink.add(alarmPlaying);
  }
}
