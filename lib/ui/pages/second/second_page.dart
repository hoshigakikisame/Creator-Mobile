import 'package:creator/creator.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreatorNav(),
      body: buildBody(),
    );
  }

  Future<void> triggerLoading() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 2), () {
      setState(() => isLoading = false);
    });
    Navigator.push(context, RouteTo(ResultPage()));
  }

  Widget buildBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Colors.white,
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  //Colors.yellow,
                  Color(0xFFFFCD5E),
                  Color(0xFFFFCD5E),
                  //Color(0xFF9c7d36),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: MediaQuery.of(context).size.height / 1.4,
            child: Card(
              // with Card
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Image.asset('assets/images/small_logo.png', width: 100),
              ),
              //elevation: 18.0,
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
            ),
          ),
        ),
        SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 1.8,
          ),
          child: ClipPath(
            clipper: Clipper(),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: isLoading
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Center(
                              child: LinearProgressIndicator(
                                  backgroundColor: Color(0xFFFFCD5E),
                                  color: Color(0xFF601E06)),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Loading...',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Tekan tombol trigger\n pada alat untuk memulai pengukuran',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () => triggerLoading())
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width / 2, 32, size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

buildMenu({Widget? icon, GestureTapCallback? onTap}) {
  return Card(
    child: InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 64,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!,
            ],
          ),
        ),
      ),
    ),
  );
}
