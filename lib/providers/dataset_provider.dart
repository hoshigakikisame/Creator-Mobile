import 'package:creator/creator.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';

enum BluetoothConnState { unknown, connected, disconnected }

class DatasetProvider with ChangeNotifier {
  DatasetProvider();

  // variables
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothConnState _connectionState = BluetoothConnState.unknown;
  List<double> _dataset = [];
  List<ScanResult> bluetoothDevices = [];
  BluetoothDevice? _connectedDevice;

  BluetoothDevice? get connectedDevice => _connectedDevice;

  Future<void> disconnectCurrentDevice() async {
    try {
      await _connectedDevice!.disconnect();
    } catch (e) {}
    _connectedDevice = null;
    _connectionState = BluetoothConnState.disconnected;
    notifyListeners();
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
    } catch (e) {}
    _connectedDevice = device;
    _connectionState = BluetoothConnState.connected;
    notifyListeners();
  }

  // setter
  set connectionState(BluetoothConnState newState) {
    _connectionState = newState;
    notifyListeners();
  }

  // getters
  BluetoothConnState get connectionState => _connectionState;

  // method
  Future<void> scanBluetoothDevice() async {
    await flutterBlue.startScan(timeout: Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) => bluetoothDevices = results);
    flutterBlue.stopScan();
    print(await FlutterBlue.instance.connectedDevices);
    notifyListeners();
  }
}
