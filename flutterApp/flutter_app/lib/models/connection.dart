import 'package:flutter/cupertino.dart';
import 'package:flutter_app/BackgroundCollectingTask.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Connection extends ChangeNotifier{
  BackgroundCollectingTask connectiontask;

  // connect to wristband
  // change ui for connection state has changed
  Future<void> connect(BluetoothDevice server) async {
    connectiontask = await BackgroundCollectingTask.connect(server);
    print("connection:" +  connectiontask.toString());
    notifyListeners();
  }

  //tells connectiontask to start
  void start() async{
  
    await connectiontask?.start();
    notifyListeners();
  }

  void stop() async{
    await connectiontask?.cancel();
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    connectiontask = null;
    notifyListeners();
  }

}