import 'package:creator/creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreatorNav(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: PieRadarChart(),
              height: 450,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Jenis Kopi",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF601E06),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Card(
                    shape: StadiumBorder(),
                    color: Color(0xFFFFCD5E),
                    elevation: 5,
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Arabika",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF601E06),
                                fontWeight: FontWeight.bold))),
                  ),
                  SizedBox(height: 10),
                  Text("Kualitas Kopi",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF601E06),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Card(
                    shape: StadiumBorder(),
                    color: Color(0xFFFFCD5E),
                    elevation: 5,
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Speciality",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF601E06),
                                fontWeight: FontWeight.bold))),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Color(0xFF601E06),
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                          textStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          elevation: 30),
                      child: Text('Selesai', style: GoogleFonts.poppins()),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PieRadarChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PieRadarChartState();
}

class _PieRadarChartState extends State {
  int touchedIndex = -1;
  bool isShowHelp = false;

  List<int> data = [8, 6, 5, 7, 10, 8, 8, 8, 10, 7, 5];

  List<Color> colors = [
    Color(0xFF89B374),
    Color(0xFFB5C266),
    Color(0xFF387490),
    Color(0xFF01ACB6),
    Color(0xFF2B2B2D),
    Color(0xFF702E52),
    Color(0xFFF2503B),
    Color(0xFFFEBE28),
    Color(0xFF3B506B),
    Color(0xFF509B84),
    Color(0xFFD4B483),
  ];

  List<String> indicators = [
    'Sweetness',
    'Acidity',
    'Clean Cup',
    'Body',
    'Over All',
    'Aroma',
    'Uniformity',
    'Flavour',
    'Balance',
    'Aftertaste',
    'Defects',
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 100,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(180.0),
              bottomRight: Radius.circular(180.0)),
          color: Color(0xFFFFCD5E),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Hasil',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: 200,
                    //margin: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tampilkan Grafik',
                            style: TextStyle(
                              color: Color(0xFF601E06),
                            ),
                          ),
                          Icon(Icons.chevron_right, color: Colors.black)
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                        textStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        await LineGraphDialog.show(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: isShowHelp
                          ? Container(
                              padding: EdgeInsets.only(
                                  left: 25, right: 25, top: 50, bottom: 0),
                              width: double.infinity,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: colors
                                          .sublist(0, 6)
                                          .asMap()
                                          .entries
                                          .map(
                                        (entry) {
                                          return Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    width: 25,
                                                    height: 25,
                                                    margin: EdgeInsets.only(
                                                        bottom: 5, right: 5),
                                                    color: entry.value),
                                                Text(indicators[entry.key])
                                              ]);
                                        },
                                      ).toList(),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          colors.sublist(6).asMap().entries.map(
                                        (entry) {
                                          return Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    width: 25,
                                                    height: 25,
                                                    margin: EdgeInsets.only(
                                                        bottom: 5, right: 5),
                                                    color: entry.value),
                                                Text(indicators[entry.key + 6])
                                              ]);
                                        },
                                      ).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              child: PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      setState(
                                        () {
                                          if (!event
                                                  .isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection ==
                                                  null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                        },
                                      );
                                    },
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 3,
                                  centerSpaceRadius: 25,
                                  sections: showingSections(),
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    child: IconButton(
                      icon: Icon(isShowHelp
                          ? Icons.donut_large_outlined
                          : Icons.help_outline_outlined),
                      onPressed: () {
                        setState(() => isShowHelp = !isShowHelp);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      11,
      (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched
            ? (data[i].toDouble() * 11.0)
            : (data[i].toDouble() * 10.0);

        return PieChartSectionData(
          color: colors[i],
          value: 9.09,
          title: data[i].toString(),
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      },
    );
  }
}
