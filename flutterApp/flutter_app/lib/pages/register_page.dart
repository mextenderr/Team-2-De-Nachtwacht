import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/helpers/LinePath.dart';
import 'package:flutter_app/pages/login_page.dart';
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
        }
      else {
        print("Username already taken");
        Toast.show("Username already taken", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
    }
    else {
      print(response.body);
      print("--Server connecion failed--");
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
            print("All fields are empty");
            Toast.show("All fields are empty", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          }
          else if (usernameController.text.isEmpty){
            print("Username is required");
            Toast.show("Username is required", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          }
          else if (ageController.text.isEmpty){
            print("Age is required");
            Toast.show("Age is required", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          }
          else if (nameController.text.isEmpty){
            print("Name is required");
            Toast.show("Name is required", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          }
          else if (passwordController.text.isEmpty){
            print("Password is required");
            Toast.show("Password is required", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          }
          else if(passwordController.text.length < 8){
            print("Password must contain at least eight characters");
            Toast.show("Password must contain at least eight characters", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          }
          else {

          signUp(usernameController.text, ageController.text, nameController.text, passwordController.text);
          Toast.show("Register succesfull", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          }
          return null;
        },
        color: Colors.transparent,
        borderSide: BorderSide(

          color: Color.fromRGBO(110, 198, 186, 1),
          width: 1,
        ),
        child: Text( _isLoading ? "Creating account..." : "Sign Up", style: TextStyle(color: Color.fromRGBO(110, 198, 186, 1))),      
      ),
    );
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
        child: Column(
          children: <Widget> [
            txtUsername("Username", Icons.person),
            SizedBox(height: 10.0),
            txtAge("Age", Icons.face),
            SizedBox(height: 10.0),
            txtName("Name", Icons.person),
            SizedBox(height: 10.0),
            txtPassword("Password", Icons.lock),
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
        labelText: 'Username',
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
        labelText: 'Age',
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
        labelText: 'Name',
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
        labelText: 'Password',
        helperText: "Password must contain at least eight characters",
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