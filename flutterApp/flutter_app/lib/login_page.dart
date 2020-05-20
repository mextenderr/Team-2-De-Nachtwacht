import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.teal,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
        ),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            buttonSection(),
          ],
        ),
      ),
     );
  }

  signIn(String email, String password) async {
    Map data = {
      'email': email,
      'password': password
    };
    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post("http://127.0.0.1:8000/login", body: data);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(() {
        _isLoading = false;
        sharedPreferences.setString("token", jsonData['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:  (BuildContext context) => MyHomePage()), (Route <dynamic> route)  => false); //MyHomePage moet nieuwe pagina worden
      });
    }
    else {
      print(response.body);
    }
  }

  Container buttonSection(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: RaisedButton(
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
        },
        color: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          ),
        child: Text("Sign In", style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget> [
          txtEmail("Email", Icons.email),
          SizedBox(height: 30.0),
          txtPassword("Password", Icons.lock),
        ],
      ),
    );
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  TextFormField txtEmail(String title, IconData icon){
    return TextFormField(
      controller: emailController,
      obscureText: title == "Email" ? false : true,
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.white70),
        icon: Icon(icon)
      ),
    );
  }
    TextFormField txtPassword(String title, IconData icon){
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.white70),
        icon: Icon(icon)
      ),
    );
  }

  Container headerSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("De Nachtwacht", style: TextStyle(color: Colors.white)),
    );
  }
}
