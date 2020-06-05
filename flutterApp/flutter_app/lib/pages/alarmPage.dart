import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/LinePath.dart';
import 'package:flutter_app/models/audioManager.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_app/soundselect.dart';

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

Widget _topSection(){
    return ClipPath(
              clipper: LinePath(),
              child: Container(
                color: Color.fromRGBO(65, 64, 66, 1),
                height: 100,
              ));
  }

  @override
  Widget build(BuildContext context) {
  AudioManager audioManager = AudioManager();
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("alarm"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        children: <Widget>[
          _topSection(),
          FlatButton(
            onPressed: () {

              if( selectedSong == 1)
              {
                const alarmAudioPath = "meadowlark.mp3";
                audioManager.play(alarmAudioPath);
              }

              else if(selectedSong == 2)
              {
                const alarmAudioPath = "alarmsound1.mp3";
                audioManager.play(alarmAudioPath);
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
              audioManager.stop();
            },
            child: Text("Geluid stoppen"),
          )
          
        ],
      ),
    );
  }
}
