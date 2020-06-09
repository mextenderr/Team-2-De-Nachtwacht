import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/helpers/LinePath.dart';
import 'package:flutter_app/pages/loginPage.dart';
import '../constants.dart' as constants;
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }

  signUp(String username, String age, String name, String password) async {
    Map data = {
      'username': username,
      'age': age,
      'name': name,
      'password': password
    };
    var body = json.encode(data);

    var response = await http.post( constants.URL + "/user", body: body);

    if (response.statusCode == 200) {
      var resBody = json.decode(response.body);
      if ( resBody["succes"] ) {
        setState(() {
          _isLoading = false;
          Navigator.push(context,  MaterialPageRoute(builder: (context) => LoginPage()),);
          });
          Toast.show("Account aangemaakt!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        }
      else {
        print("Gebruikersnaam al in gebruik");
        Toast.show("Gebruikersnaam al in gebruik", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
    }
    else {
      print(response.body);
      Toast.show("Geen verbinding", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }
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
  Container buttonSection(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: OutlineButton(
        onPressed: () {
          if(usernameController.text.isEmpty && ageController.text.isEmpty && nameController.text.isEmpty && passwordController.text.isEmpty){
            Toast.show("Vul verplichte velden in", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          }
          else if(passwordController.text.length < 8){
            Toast.show("Wachtwoord moet minimaal 8 tekens hebben", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          }
          else {
            signUp(usernameController.text, ageController.text, nameController.text, passwordController.text);
          }
        },
        color: Colors.transparent,
        borderSide: BorderSide(

          color: Color.fromRGBO(110, 198, 186, 1),
          width: 1,
        ),
        child: Text( _isLoading ? "Account aan het maken..." : "Registreren", style: TextStyle(color: Color.fromRGBO(110, 198, 186, 1))),      
      ),
    );
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
        child: Column(
          children: <Widget> [
            txtUsername("Gebruikersnaam", Icons.person),
            SizedBox(height: 10.0),
            txtAge("Leeftijd", Icons.face),
            SizedBox(height: 10.0),
            txtName("Roepnaam", Icons.person),
            SizedBox(height: 10.0),
            txtPassword("Wachtwoord", Icons.lock),
        ],
      ),
    );
  }

  TextEditingController usernameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  TextFormField txtUsername(String title, IconData icon){
    return TextFormField(
      maxLength: 32,
      controller: usernameController,
      //obscureText: title == "Username" ? false : true,
      style: TextStyle(color: Color.fromRGBO(65, 64, 66, 1)),
      decoration: InputDecoration(
        labelText: 'Gebruikersnaam',
        //hintText: title,
        hintStyle: TextStyle(color: Color.fromRGBO(65, 64, 66, 1)),
        icon: Icon(icon)
      ),
    );
  }

    TextFormField txtAge(String title, IconData icon){
    return TextFormField(
      controller: ageController,
      keyboardType: TextInputType.number,
      //obscureText: title == "Age" ? false : true,
      style: TextStyle(color: Color.fromRGBO(65, 64, 66, 1)),
      decoration: InputDecoration(
        labelText: 'Leeftijd',
        //hintText: title,
        hintStyle: TextStyle(color: Color.fromRGBO(65, 64, 66, 1)),
        icon: Icon(icon)
      ),
      maxLength: 3,
    );
  }

  TextFormField txtName(String title, IconData icon){
    return TextFormField(
      maxLength: 32,
      controller: nameController,
      //obscureText: title == "Name" ? false : true,
      style: TextStyle(color: Color.fromRGBO(65, 64, 66, 1)),
      decoration: InputDecoration(
        labelText: 'Roepnaam',
        //hintText: title,
        hintStyle: TextStyle(color: Color.fromRGBO(65, 64, 66, 1)),
        icon: Icon(icon)
      ),
    );
  }
    TextFormField txtPassword(String title, IconData icon){
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      style: TextStyle(color: Color.fromRGBO(65, 64, 66, 1)),
      decoration: InputDecoration(
        labelText: 'Wachtwoord',
        helperText: "Wachtwoord moet uit minimaal 8 tekens bestaan",
        //hintText: title,
        hintStyle: TextStyle(color: Color.fromRGBO(65, 64, 66, 1)),
        icon: Icon(icon)
      ),
    );
  }

  Center headerSection() {
    return Center(
     
      child: Text("De Nachtwacht", style: TextStyle(fontSize:20 ,color: Color.fromRGBO(110, 198, 186, 1))),
    );
  }
}