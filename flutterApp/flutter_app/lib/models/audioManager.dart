import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  bool alarmPlaying = false;
  void Function() notifyChange;

  AudioManager._privateConstructor() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer, respectSilence: false);
  }

  static final AudioManager _instance = AudioManager._privateConstructor();

  factory AudioManager({Function callBack}) {
    _instance.notifyChange = callBack;
    return _instance;
  }

  void stop(){
    advancedPlayer.stop();
    alarmPlaying = true;
    if(notifyChange != null) notifyChange();
  }

  void play(String path){
    audioCache.play(path);
    alarmPlaying = true;
     if(notifyChange != null) notifyChange();
  }
}
