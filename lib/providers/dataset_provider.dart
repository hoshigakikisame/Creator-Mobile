import 'dart:convert';
import 'dart:typed_data';

import 'package:creator/creator.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

enum BluetoothConnState { unknown, connected, disconnected }

class DatasetProvider with ChangeNotifier {
  DatasetProvider() {
    loadPreferences();
  }

  void loadPreferences() {
    FlutterBluetoothSerial.instance.state.then((state) {
      bluetoothState = state;
    });

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      bluetoothState = state;
      // For retrieving the paired devices list
    });

    // notifyListeners();
  }

  void startListeningInput() {
    connection?.input?.listen((Uint8List data) {
      print(data);
    });
  }

  Future<void> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    bluetoothState = await FlutterBluetoothSerial.instance.state;

    // If the Bluetooth is off, then turn it on first
    // and then retrieve the devices that are paired.
    if (bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
    } else {
      await getPairedDevices();
    }
  }

  List<BluetoothDevice> devicesList = [];

  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class

    devicesList = devices;
    notifyListeners();
  }

  bool isDisconnecting = false;

  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  set bluetoothState(newVal) {
    _bluetoothState = newVal;
    notifyListeners();
  }

  BluetoothState get bluetoothState => _bluetoothState;

  // Get the instance of the Bluetooth
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

  // Track the Bluetooth connection with the remote device
  BluetoothConnection? connection;

  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection!.isConnected;

  int deviceState = 0;

  bool _connected = false;

  set connected(newBool) {
    _connected = newBool;
    notifyListeners();
  }

  bool get connected => _connected;

  void disconnect() async {
    // Closing the Bluetooth connection
    await connection!.close();

    // Update the [_connected] variable
    if (!connection!.isConnected) {}
    connected = false;
    currentDevice = null;
    notifyListeners();
  }

  sendOnMessageToBluetooth() async {
    connection?.output.add(utf8.encode("1" + "\r\n") as Uint8List);
    await connection?.output.allSent;
    // show('Device Turned On');
    // setState(() {
    // _deviceState = 1; // device on
    // });
  }

  BluetoothDevice? currentDevice;

  void connect(device) async {
    if (!isConnected) {
      // Trying to connect to the device using
      // its address
      try {
        await BluetoothConnection.toAddress(device.address).then((_connection) {
          print('Connected to the device');
          connection = _connection;
          currentDevice = device;
          // Updating the device connectivity
          // status to [true]

          _connected = true;

          // This is for tracking when the disconnecting process
          // is in progress which uses the [isDisconnecting] variable
          // defined before.
          // Whenever we make a disconnection call, this [onDone]
          // method is fired.
          connection!.input!.listen(null).onDone(() {
            if (isDisconnecting) {
              currentDevice = null;
              _connected = false;
              print('Disconnecting locally!');
            } else {
              currentDevice = null;
              _connected = false;
              print('Disconnected remotely!');
            }
            notifyListeners();
          });
        });
      } catch (e) {}
      // .catchError((error) {
      //   print('Cannot connect, exception occurred');
      //   // print(error);
      // });
    }
    notifyListeners();
  }
}
