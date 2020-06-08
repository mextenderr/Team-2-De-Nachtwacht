
import 'package:flutter/cupertino.dart';
import 'audioManager.dart';

class Alarm extends ChangeNotifier{
  var audioManagerStream;
  var subscription;
  AudioManager audioManager;
  bool playing = false; 


  Alarm(){
    print("created!!");
    audioManager = AudioManager();
    audioManagerStream = AudioManager().stream;
    subscription = audioManagerStream.listen(
      (startedPlaying) {
        print("playing");
        if(startedPlaying){
         _isPlaying();
        }
        else{
          _stoppedPlaying();
        }
      },
      onError: (err){
        print(err);
      }
    );
  }

  void _isPlaying(){
    playing = true;
    print("notifying!");
    notifyListeners();
  }

  void _stoppedPlaying(){
    print("notifying!");
    playing = false;
    notifyListeners();
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