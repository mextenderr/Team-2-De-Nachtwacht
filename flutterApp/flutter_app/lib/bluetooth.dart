import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/BackgroundCollectedPage.dart';
import 'package:flutter_app/BackgroundCollectingTask.dart';
import 'package:flutter_app/helpers/LinePath.dart';

import 'package:flutter_app/pages/SelectBondedDevicePage.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'constants.dart' as constants;
import 'models/connection.dart';

class Bluetooth extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BluetoothPageState();
  }
}

class BluetoothPageState extends State {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BackgroundCollectingTask _collectingTask;

  bool _autoAcceptPairingRequests = false;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if (await FlutterBluetoothSerial.instance.isEnabled) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Device'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            // height: 1000,
            child: ListView(
              padding: EdgeInsets.only(top:0),
              children: <Widget>[
              ClipPath(
              clipper: LinePath(),
              child: Container(
                color: Color.fromRGBO(65, 64, 66, 1),
                height: 100,
              )),
          
          SwitchListTile(
                  title: const Text('Enable Bluetooth to connect device'),
                  value: _bluetoothState.isEnabled,
                  activeColor: constants.COLOR,
                  onChanged: (bool value) {
                    // Do the request and update with the true value then
                    future() async {
                      // async lambda seems to not working
                      if (value)
                        await FlutterBluetoothSerial.instance.requestEnable();
                      else
                        await FlutterBluetoothSerial.instance.requestDisable();
                    }

                    future().then((_) {
                      setState(() {});
                    });
                  },
                ) ,
                Container(
                  height: 400,
                  child: Center(
                    child: _icon()
                  )
                ),
          
          ListTile(title: _button()),
        ])));
  }


  Widget _icon(){
    return Consumer<Connection>(builder: (context, connection, child) {
      bool hasConnection = connection.connectiontask != null ?true: false;
      Color color = Colors.grey[100];
      double size = 300.0;
      if(hasConnection){
        return Icon(Icons.bluetooth_connected, size: size, color: color,);
      }
      else{
        if(_bluetoothState.isEnabled){
          return Icon(Icons.bluetooth_searching, size: size,color: color);
        }
        return Icon(Icons.bluetooth_disabled, size: size, color: color);
      }
    });
  }
  Widget _button() {
    return Consumer<Connection>(builder: (context, connection, child) {
      bool hasConnection = connection.connectiontask != null ? true : false;
      return OutlineButton(
        color: Colors.transparent,
        borderSide: BorderSide(
          
          color: Color.fromRGBO(110, 198, 186, 1),
          width: 1,
        ), 
      
        child: hasConnection
            ? const Text('Disconnect device',  style: TextStyle(color: Color.fromRGBO(110, 198, 186, 1)))
            : const Text('Connect to start collecting',  style: TextStyle(color: Color.fromRGBO(110, 198, 186, 1))),
        onPressed: () async {
          if (hasConnection) {
            _stopBackgroundTask(context);
          } else {
            final BluetoothDevice selectedDevice =
                await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return SelectBondedDevicePage(checkAvailability: false);
                },
              ),
            );

            if (selectedDevice != null) {
              _startBackgroundTask(context, selectedDevice);
            }
          }
        },
      );
    });
  }

  // Build the expensive widget here.

}

void _stopBackgroundTask(BuildContext context) {
  Provider.of<Connection>(context).stop();
}

void _startBackgroundTask(BuildContext context, BluetoothDevice server) {
  Provider.of<Connection>(context).connect(server);
}
