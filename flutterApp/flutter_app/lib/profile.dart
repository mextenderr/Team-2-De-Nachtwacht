import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override 
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  SharedPreferences sharedPreferences;

  @override
    void initState(){
      super.initState();
      checkLoginStatus();
    }
  
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:  (BuildContext context) => MainPage()), (Route <dynamic> route)  => false); //MyHomePage moet nieuwe pagina worden

    }

  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("De Nachtwacht", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
            
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:  (BuildContext context) => MainPage()), (Route <dynamic> route)  => false); //MyHomePage moet nieuwe pagina worden
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(child: Text("Main Page")),
      drawer: Drawer(),
      );
    }
  }