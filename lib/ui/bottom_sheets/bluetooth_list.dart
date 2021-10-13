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
  bool _isLoading = false;

  @override
  void initState() {
    final DatasetProvider provider = context.read();
    setState(() => _isLoading = true);
    provider
        .scanBluetoothDevice()
        .then((e) => setState(() => _isLoading = false));
    super.initState();
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
              child: buildList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    final DatasetProvider provider = context.watch();
    return ListView(
      children: [
        ListTile(
          subtitle: Text("Connected"),
        ),
        if (provider.connectionState == BluetoothConnState.connected)
          ListTile(
            title: Text(provider.connectedDevice!.name),
            subtitle: Text(provider.connectedDevice!.id.toString()),
            trailing: IconButton(
              icon: Icon(Icons.bluetooth_disabled, color: Colors.red),
              onPressed: () async {
                final DatasetProvider provider = context.read();
                setState(() => _isLoading = true);
                await provider.disconnectCurrentDevice();
                setState(() => _isLoading = false);
              },
            ),
          ),
        Divider(),
        ListTile(
          subtitle: Text("Unconnected"),
        ),
      ]..addAll(
          _isLoading
              ? [
                  SizedBox(height: 75),
                  Center(
                      child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.brown,
                    ),
                  ))
                ]
              : provider.bluetoothDevices.map(
                  (item) {
                    return ListTile(
                      title: Text(item.device.name == ''
                          ? '(unknown device)'
                          : item.device.name),
                      subtitle: Text(item.device.id.toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.bluetooth,
                            color: provider.connectionState ==
                                    BluetoothConnState.connected
                                ? Colors.grey.shade400
                                : Colors.blue),
                        onPressed: () async {
                          final DatasetProvider provider = context.read();
                          if (provider.connectionState !=
                              BluetoothConnState.connected) {
                            setState(() => _isLoading = true);
                            await provider.connectToDevice(item.device);
                            setState(() => _isLoading = false);
                          }
                        },
                      ),
                    );
                  },
                ).toList(),
        ),
    );
  }
}
