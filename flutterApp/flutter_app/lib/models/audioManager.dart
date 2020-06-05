import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_app/track.dart';
import 'package:flutter_app/tracks.dart' as tracks;

class AudioManager {
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  Track currentTrack;
  bool alarmPlaying = false;
  void Function() notifyChange;

  AudioManager._privateConstructor() {
    advancedPlayer = new AudioPlayer();
    currentTrack = tracks.tracklist[0];
    audioCache = new AudioCache(fixedPlayer: advancedPlayer, respectSilence: false);
  }

  static final AudioManager _instance = AudioManager._privateConstructor();

  factory AudioManager({Function callBack}) {
    _instance.notifyChange = callBack;
    return _instance;
  }

  void setTrack(Track track){
    currentTrack = track;
  }

  void stop(){
    advancedPlayer.stop();
    alarmPlaying = false;
    // notifyChange();
  }

  void play(){
    audioCache.play(currentTrack.path);
    alarmPlaying = true;
  //  notifyChange();
  }
}
