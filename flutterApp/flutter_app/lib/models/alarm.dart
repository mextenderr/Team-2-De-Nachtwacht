import 'package:flutter/cupertino.dart';
import 'audioManager.dart';

class Alarm extends ChangeNotifier{
  AudioManager audioManager;
  Alarm(){
    audioManager = AudioManager(callBack: this.managerChangeHandler);
  }

  void play(String path){
    audioManager.play(path);
  }

    void stop(){
    audioManager.stop();
  }


  Function managerChangeHandler(){
    notifyListeners();
    return null;
  }

}