class User {
  int uid;
  String name;
  List<Map<String, dynamic>> points = [];
  User._privateConstructor();
 
  int total = 0;
  int count = 0;

  static final User _instance = User._privateConstructor();

  factory User() {
    return _instance;
  }

  void addBeat(int beat){
    if(count == 0){
      count ++;
      DateTime now = DateTime.now();
      Map<String, dynamic> point = {"value": 0, "date": now};
    }
    if(count < 100){
      total += beat;
      count ++;
    }
    else{
      var avg = total / count;
      DateTime now = DateTime.now();
      Map<String, dynamic> point = {"value": avg, "date": now};

      points.add(
        point
      );
    }
  }
  

}