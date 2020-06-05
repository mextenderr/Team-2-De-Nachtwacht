import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/LinePath.dart';
import 'package:flutter_app/models/alarm.dart';
import 'package:flutter_app/models/audioManager.dart';
import 'package:flutter_app/pages/soundselectPage.dart';
import 'package:flutter_app/tracks.dart' as tracks;
import 'package:flutter_app/constants.dart' as constants;
import 'package:flutter_app/track.dart';
import 'package:provider/provider.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({
    Key key,
  }) : super(key: key);

  @override
  AlarmPageState createState() => AlarmPageState();
}

class AlarmPageState extends State<AlarmPage> {
  Track track;
  AudioManager audioManager = AudioManager();
  bool playing;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  	playing = audioManager.alarmPlaying;
  }

  void _toSoundselectPage() async {
    final Track selectedTrack = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Soundselect()),
    );
    
    if (selectedTrack != null) {
      audioManager.setTrack(selectedTrack);

      setState(() {
        track = selectedTrack;
      });
    }
  }

  Widget _topSection() {
    return ClipPath(
        clipper: LinePath(),
        child: Container(
          color: Color.fromRGBO(65, 64, 66, 1),
          height: 100,
        ));
  }

 
  void _stopPlaying(){
    audioManager.stop();
    setState(() {
      playing = false;
    });
  }

  void _startPlaying(){
    audioManager.play();
    setState(() {
      playing = true;
    });
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
          
          ListTile(
            title: Row(
              children: <Widget>[
                Text("Current alarm: "),
                Text("${audioManager.currentTrack.name}", style: TextStyle(color: constants.COLOR),)
              ],
            ),
          )
          ,
          Container(
              height: 400,
              child: Center(
                  child: Icon(
                Icons.alarm,
                size: 300,
                color: Colors.grey[200],
              ))),
          playing? Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlineButton(borderSide: BorderSide(color: constants.COLOR),child:Text("Stop sound", style:TextStyle(color:constants.COLOR)),onPressed:(){_stopPlaying();}),
            ):Container(width:0, height:0),
          !playing? Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlineButton(borderSide: BorderSide(color: constants.COLOR),child:Text("Play sound", style:TextStyle(color:constants.COLOR)), onPressed: (){
              _startPlaying();
            }),
          ): Container(width:0, height: 0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlineButton(
              onPressed: () {
                _toSoundselectPage();
              },
              color: Colors.transparent,
              borderSide: BorderSide(
                color: Color.fromRGBO(110, 198, 186, 1),
                width: 1,
              ),
              child: Text(
                'Chose sound',
                textAlign: TextAlign.center,
                style: TextStyle(color: constants.COLOR),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
