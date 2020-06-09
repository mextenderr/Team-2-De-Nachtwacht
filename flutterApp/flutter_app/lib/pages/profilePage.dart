import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/LinePath.dart';
import 'package:flutter_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/constants.dart' as constants;

class ProfilePage extends StatefulWidget {
  @override 
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<Map<String, dynamic>> _getData(context) async{
    Map<String, dynamic> userData = {
      
    };
    User user  = Provider.of<User>(context); 
    var response = await http.get(constants.URL + "/user?${user.uid}");
    if(response.statusCode == 200){
      var data = json.decode(response.body);
        if(data["succes"]){
          userData["age"] = data["user"]["age"];
          userData["name"] = data["user"]["name"];
          userData["username"] = data["user"]["username"];
      }
    }

    return userData;

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
  Widget build (BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Profiel", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/'); //MyHomePage moet nieuwe pagina worden
            },
            child: Icon(Icons.exit_to_app,  color: Colors.white),
          ),
        ],
      ),
      body: Column(
       children: <Widget>[
          _topSection(),
          Expanded(
            child:_getDataList(context),
                      )
                    ],
                  ),
                  drawer: Drawer(),
                  );
                }
            
            

          

           Widget _getDataList(context) {
              return FutureBuilder<Map<String, dynamic>>(
                future: _getData(context),
                builder:(BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
       
        if (snapshot.hasData) {
          return _dataList(snapshot.data);
                  } else if (snapshot.hasError) {
                    return Center(child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.sentiment_very_dissatisfied, color: constants.COLOR,),
                        Text("Sorry, er ging iets fout"),
                      ],
                    ));
                  } else {
                    return Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }});
                     
          }
          
          Widget _dataList(Map<String, dynamic>data) {
            
          }
}