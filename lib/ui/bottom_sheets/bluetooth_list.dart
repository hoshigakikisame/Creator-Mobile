import 'package:creator/creator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BluetoothList extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      isDismissible: false,
      builder: (context) => BluetoothList(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20.0),
          topRight: const Radius.circular(20.0),
        ),
      ),
    );
  }

  @override
  _BluetoothListState createState() => _BluetoothListState();
}

class _BluetoothListState extends State<BluetoothList> {
  // bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final DatasetProvider provider = context.read();
    try {
      provider.getPairedDevices();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: SizedBox(
                width: 20.0,
                height: 4.0,
                child: Container(color: Theme.of(context).dividerColor),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
                flex: 2,
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Paired Device'),
                        IconButton(
                            icon: Icon(CupertinoIcons.gear),
                            onPressed: () {
                              FlutterBluetoothSerial.instance.openSettings();
                            })
                      ]),
                  Expanded(
                    child: buildList(),
                  )
                ])),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    final DatasetProvider provider = context.watch();
    // return Container();
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: provider.devicesList.length,
        itemBuilder: (context, index) {
          final item = provider.devicesList[index];
          return ListTile(
              title: Text(item.name! == '' ? '(unknown device)' : item.name!),
              selected: item == provider.currentDevice,
              trailing: IconButton(
                icon: Icon(
                    item == provider.currentDevice
                        ? Icons.bluetooth_disabled
                        : Icons.bluetooth,
                    color: item == provider.currentDevice ? Colors.red : null),
                onPressed: () {
                  final DatasetProvider provider = context.read();
                  provider.connected
                      ? provider.disconnect()
                      : provider.connect(item);
                },
              ));
        });
  }
}
