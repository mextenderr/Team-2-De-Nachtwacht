import 'package:flutter/cupertino.dart';
import 'audioManager.dart';

class Alarm extends ChangeNotifier{
  AudioManager audioManager;
  bool playing = false; 
  Alarm(){
    audioManager = AudioManager(callBack: this.managerChangeHandler);
  }

  void play(){
    audioManager.play();
    playing = true;
    notifyListeners();
  }

  void stop(){
    audioManager.stop();
    playing = false;
    notifyListeners();
  }


   void managerChangeHandler(){
    print("called");
    notifyListeners();
    return null;
  }

}