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

  //calculates an average of the last 100 data points that are sent to the server for plotting on graph on homepage
  //wristband sends every second, avg of 4 measurements is sent to server and to here, 
  //so around every 400 seconds (6.6 minutes) an average is calculated and stored.  
  void addBeat(int beat){
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
    print(count);
  }


}