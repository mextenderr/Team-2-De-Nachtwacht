
import 'dart:convert';
import 'package:flutter_app/helpers/LinePath.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/pages/register_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constants.dart' as constants;

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
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(colors: [
              //     Colors.blue,
              //     Colors.teal,
              //   ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              // ),
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
          user.uid = data['uid'];
          user.name = username;
          Navigator.of(context).pushReplacementNamed('/home');
         
        }
      } 
      else {
        print(response.body);
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
          setState(() {
            _isLoading = true;
          });
          signIn(usernameController.text, passwordController.text);
        },
        color: Colors.transparent,
        borderSide: BorderSide(
          
          color: Color.fromRGBO(110, 198, 186, 1),
          width: 1,
        ), 
      
        child: Text("Sign In", style: TextStyle(color: Color.fromRGBO(110, 198, 186, 1))),
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
          Navigator.push(context,  MaterialPageRoute(builder: (context) => RegisterPage()),);
        },
        color: Colors.transparent,
        borderSide: BorderSide(
          
          color: Color.fromRGBO(110, 198, 186, 1),
          width: 1,
        ), 
        child: Text("No account? Sign up!",
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
          txtUsername("Username", Icons.person),
          SizedBox(height: 30.0),
          txtPassword("Password", Icons.lock),
        ],
      ),
    );
  }

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  TextFormField txtUsername(String title, IconData icon) {
    return TextFormField(
      controller: usernameController,
      obscureText: title == "Username" ? false : true,
      style: TextStyle(color: Color.fromRGBO(65, 64, 66, 1)),
      decoration: InputDecoration(
          hintText: title,
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
          hintText: title,
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
