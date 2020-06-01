import 'package:flutter/material.dart';
import 'package:flutter_app/alarm.dart';
import 'package:flutter_app/bluetooth.dart';
import 'package:flutter_app/login_page.dart';
import 'package:flutter_app/register_page.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
  MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
          primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home' : (context) => MyHomePage()
      },
      
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool waiting = false;
  String _response = "";
  void _toInlogPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
  }

  void _toBluetoothPage() {
    Navigator.push(context,  MaterialPageRoute(builder: (context) => Bluetooth()),);

  }

   void _toAlarmPage() {
    Navigator.push(context,  MaterialPageRoute(builder: (context) => Alarm()),);

  }

  void _sendRequest(){
    setState(() {
      waiting = true;
    });
    _request().then((value){
      setState(() {
        waiting = false;
        _response = value;
      });
    });
  }

  Future<String> _request() async{

    final response = await http.get("http://127.0.0.1:5001/true");
    return response.body;
  }
  



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Home"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        
            FlatButton(onPressed: _toAlarmPage, child: Text("Alarm")),
            FlatButton(onPressed: _toBluetoothPage, child: Text("Bluetooth")),
            
          ],
        ),
      ),
    );
  }
}
