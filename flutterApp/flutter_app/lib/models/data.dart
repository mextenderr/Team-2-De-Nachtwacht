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
    Timer.periodic(new Duration(seconds: 1), (timer) {
      getPoints();
    });
  }

  void getPoints() {

    data = user.points;
    if(data.length % 10 == 1){
      notifyListeners();
    }
  }  
}
