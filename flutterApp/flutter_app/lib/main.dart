import 'package:flutter/material.dart';
import 'package:flutter_app/models/alarm.dart';

import 'package:flutter_app/models/connection.dart';
import 'package:flutter_app/models/data.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/pages/homePage.dart';
import 'package:flutter_app/pages/loginPage.dart';
import 'package:flutter_app/pages/registerPage.dart';


import 'package:provider/provider.dart';

void main(){runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Alarm>(create: (context) => Alarm()),
        ChangeNotifierProvider<Data>(create: (context) => Data()),
        ChangeNotifierProvider<Connection>(create: (context) => Connection())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
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
        '/home': (context) => MyHomePage(),
      },
    );
  }
}
