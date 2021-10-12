import 'package:creator/creator.dart';
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
    return ListView.builder(
      itemCount: provider.connectedDevice != null
          ? provider.bluetoothDevices.length + 1
          : provider.bluetoothDevices.length,
      itemBuilder: (context, index) {
        final item = provider.bluetoothDevices[provider.connectedDevice != null
            ? index <= 0
                ? index
                : index - 1
            : index];
        if (index == 0 && provider.connectedDevice != null)
          return ListTile(
            title: Text(provider.connectedDevice!.name),
            subtitle: Text(provider.connectedDevice!.id.toString()),
            leading: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () async {
                  final DatasetProvider provider = context.read();
                  await provider.disconnectCurrentDevice();
                },
                // ignore: unrelated_type_equality_checks
                child: Text("Disconnect")),
          );
        return ListTile(
          title: Text(
              item.device.name == '' ? '(unknown device)' : item.device.name),
          subtitle: Text(item.device.id.toString()),
          leading: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:
                    provider.connectionState == BluetoothConnState.connected
                        ? Colors.grey
                        : Colors.blue,
              ),
              onPressed: () async {
                final DatasetProvider provider = context.read();
                if (provider.connectionState == BluetoothConnState.disconnected)
                  await provider.connectToDevice(item.device);
              },
              // ignore: unrelated_type_equality_checks
              child: Text("Connect")),
        );
      },
    );
  }
}
