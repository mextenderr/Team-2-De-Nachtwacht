import 'package:flutter/cupertino.dart';
import 'audioManager.dart';

class Alarm extends ChangeNotifier{
  AudioManager audioManager;
  Alarm(){
    audioManager = AudioManager(callBack: this.ManagerChangeHandler);
  }

  void play(String path){
    audioManager.play(path);
  }

    void stop(){
    audioManager.stop();
  }


  Function ManagerChangeHandler(){
    notifyListeners();
  }

}