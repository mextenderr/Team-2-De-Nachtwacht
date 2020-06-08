import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/user.dart';

class Data extends ChangeNotifier {
  int count = 0;
  int total = 0;
  User user;
  List<Map<String, dynamic>> data = [];

  Data() {
    user = User();

    Map<String, dynamic> point = {"value": 0, "date": DateTime.now()};
    data.add(point);
    // check every second if User has enough datapoints
    Timer.periodic(new Duration(seconds: 1), (timer) {
      getPoints();
    });
  }

  // every time user got 10 new points the graph is updated
  // graph is updated every 66 minutes, can be changed 
  void getPoints() {
    data = user.points;
    if(data.length % 10 == 1){
      notifyListeners();
    }
  }  
}
