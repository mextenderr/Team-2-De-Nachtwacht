
import 'dart:convert';
import 'package:flutter_app/helpers/LinePath.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/pages/register_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constants.dart' as constants;
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Column(

        children: <Widget>[
          topSection()
          ,Expanded(
                      child: Container(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                      children: <Widget>[
                        
                        textSection(),
                        buttonSection(),
                        buttonRegisterSection(),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  signIn(String username, String password) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String req = constants.URL + '/login';
    final response = await http.get(req,
        headers: <String, String>{'authorization': basicAuth});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['succes']) {
        var user = User();
        // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        
          // sharedPreferences.setString("token", jsonData['token']);
          print("User is logged in");
          Toast.show("Ingelogd!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          user.uid = data['uid'];
          user.name = username;
          Navigator.of(context).pushReplacementNamed('/home');
        }
        else {
          Toast.show("Account bestaat niet", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        }
      } 
      else {
        print(response.body);
        Toast.show("Geen verbinding...", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }
    setState(() {
          _isLoading = false;
        });
    }


  Widget topSection(){
    return ClipPath(
            
            clipper: LinePath(),
            child: Container(
              color: Color.fromRGBO(65, 64, 66, 1),
              
              height: 250,
              child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Center(
                        child:Image(
                          width: 120,
                          image: AssetImage('assets/logo/logo.png' )
                      ),
                      
            ),
                    ),
            headerSection()
                  ],
                ),
              )
          );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: OutlineButton(
        onPressed: () {
          if (usernameController.text.isEmpty && passwordController.text.isEmpty){
            print("Username and password are required");
            Toast.show("Gebruiersnaam en wachtwoord zijn vereist", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          }
          else if (usernameController.text.isEmpty){
            print("Gebruikersnaam is vereist");
            Toast.show("Gebruikersnaam is vereist", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          }
          else if (passwordController.text.isEmpty){
            print("Wachtwoord is vereist");
            Toast.show("Wachtwoord is vereist", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          }
          else{
          setState(() {
            _isLoading = true;
          });
          signIn(usernameController.text, passwordController.text);}
          return null;
        },
        color: Colors.transparent,
        borderSide: BorderSide(
          
          color: Color.fromRGBO(110, 198, 186, 1),
          width: 1,
        ), 
      
        child: Text("Inloggen", style: TextStyle(color: Color.fromRGBO(110, 198, 186, 1))),
      ),
    );
  }

  Container buttonRegisterSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: OutlineButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()),);
        },
        color: Colors.transparent,
        borderSide: BorderSide(
          
          color: Color.fromRGBO(110, 198, 186, 1),
          width: 1,
        ), 
        child: Text("Geen account? Maak nu aan!",
            style: TextStyle(color: Color.fromRGBO(110, 198, 186, 1))),
      ),
    );
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          txtUsername("Gebruikersnaam", Icons.person),
          SizedBox(height: 10.0),
          txtPassword("Wachtwoord", Icons.lock),
        ],
      ),
    );
  }

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  TextFormField txtUsername(String title, IconData icon) {
    return TextFormField(
      maxLength: 32,
      controller: usernameController,
      //obscureText: title == "Username" ? false : true,
      style: TextStyle(color: Color.fromRGBO(65, 64, 66, 1)),
      decoration: InputDecoration(
          labelText: 'Gebruikersnaam',
          //hintText: title,
          hintStyle: TextStyle(color: Color.fromRGBO(65, 64, 66, 1)),
          icon: Icon(icon)),
    );
  }

  TextFormField txtPassword(String title, IconData icon) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      style: TextStyle(color: Color.fromRGBO(65, 64, 66, 1)),
      decoration: InputDecoration(
          labelText: 'Wachtwoord',
          //hintText: title,
          hintStyle: TextStyle(color: Color.fromRGBO(65, 64, 66, 1)),
          icon: Icon(icon)),
    );
  }

  Center headerSection() {
    return Center(
     
      child: Text("De Nachtwacht", style: TextStyle(fontSize:20 ,color: Color.fromRGBO(110, 198, 186, 1))),
    );
  }
}
