import 'package:creator/creator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late AnimationController animationController;

  @override
  void dispose() {
    final DatasetProvider provider = context.read();
    // Avoid memory leak and disconnect
    if (provider.isConnected) {
      provider.isDisconnecting = true;
      provider.connection?.dispose();
      provider.connection = null;
    }

    super.dispose();
  }

  @override
  initState() {
    super.initState();
    final DatasetProvider provider = context.read();
    if (mounted) provider.loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreatorNav(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    final DatasetProvider provider = context.watch();
    return Container(
      color: Color(0xFFFFCD5E),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  // with Card
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child:
                        Image.asset('assets/images/small_logo.png', width: 100),
                  ),
                  //elevation: 18.0,
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                ),
                Text('CREATOR',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.italic),
                    )),
                Text(
                  'COFFEE GRADE DETECTOR',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mulai Pengukuran',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF601E06))),
                      Switch(
                          activeColor: Color(0xFF601E06),
                          value: provider.bluetoothState.isEnabled,
                          onChanged: (value) {
                            future() async {
                              if (value) {
                                // Enable Bluetooth
                                await FlutterBluetoothSerial.instance
                                    .requestEnable();
                              } else {
                                // Disable Bluetooth
                                await FlutterBluetoothSerial.instance
                                    .requestDisable();
                              }

                              // In order to update the devices list
                              await provider.getPairedDevices();

                              // Disconnect from any device before
                              // turning off Bluetooth
                              if (provider.connected) {
                                provider.disconnect();
                              }
                            }

                            future().then((_) {
                              setState(() {});
                            });
                          })
                    ],
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text(provider.currentDevice?.name ?? 'Hubungkan',
                      style: TextStyle(color: Color(0xFF601E06))),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      textStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      elevation: 30),
                  onPressed: () async {
                    await BluetoothList.show(context);
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Color(0xFF601E06),
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      textStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      elevation: 30),
                  child: Text('Mulai Pengukuran', style: GoogleFonts.poppins()),
                  onPressed: () {
                    // await FlutterBlue.instance.state.first == BluetoothState.on
                    Navigator.push(context, RouteTo(SecondPage()));
                    //     : showInfoBanner(content: "Bluetooth tidak aktif");
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
