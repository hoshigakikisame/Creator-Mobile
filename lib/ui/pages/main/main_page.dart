import 'package:creator/creator.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isScanning = false;
  late AnimationController animationController;

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
                  child: Text(
                      provider.connectionState == BluetoothConnState.connected
                          ? "Tersambung ke ${provider.connectedDevice!.name}"
                          : 'Hubungkan',
                      style: GoogleFonts.poppins()),
                  onPressed: () async {
                    await FlutterBlue.instance.state.first == BluetoothState.on
                        ? await BluetoothList.show(context)
                        : showInfoBanner(content: "Bluetooth tidak aktif");
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text('Mulai Pengukuran',
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
                  onPressed: () {
                    Navigator.push(context, RouteTo(SecondPage()));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
