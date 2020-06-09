import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/LinePath.dart';
import 'package:flutter_app/track.dart';
import 'package:flutter_app/tracks.dart' as tracks;
import 'package:flutter_app/constants.dart' as constants;

class Soundselect extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return SoundselectState();
  }
  
  
}

class SoundselectState extends State{
  int mp3soundselect;
  
  void _toAlarmPage(track) {
    Navigator.pop(context, track);

  }

  Widget _listBuilder(){
    List<Track> list = tracks.tracklist;
    return ListView.separated
  (
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Divider(color: constants.COLOR),
    ),
    padding: EdgeInsets.only(top: 0.0),
    itemCount: list.length,
    itemBuilder: (BuildContext ctxt, int index) {
      Track track = list[index];
     return new ListTile(title: Text(track.name,),
     
     onTap: (){
       _toAlarmPage(track);
     });
    }
  );
  }


  Widget _topSection() {
    return ClipPath(
        clipper: LinePath(),
        child: Container(
          color: Color.fromRGBO(65, 64, 66, 1),
          height: 100,
        ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Select Sound"),
      ),
      
      body: Container(
        child: Column(
          children: <Widget>[
            _topSection(),
            Expanded(child: _listBuilder()),
          ],
        ),
      )
    );
      
      
    
  }
  
} 