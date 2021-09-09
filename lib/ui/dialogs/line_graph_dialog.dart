import 'package:creator/creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LineGraphDialog extends StatefulWidget {

	static Future<void> show(BuildContext context) async {
		await showDialog(
			context: context,
			useRootNavigator: false,
			builder: (context) => LineGraphDialog(),
		);
	}

	@override
	_LineGraphDialogState createState() => _LineGraphDialogState();
}

class _LineGraphDialogState extends State<LineGraphDialog> {
	@override
	Widget build(BuildContext context) {
		return Dialog(
			backgroundColor: Colors.transparent,
			 insetPadding: EdgeInsets.zero,
			shape: RoundedRectangleBorder(
    			borderRadius: BorderRadius.all(Radius.circular(20.0))
			),
	      child: Stack(
	      	children: [
	      		Container(
	      			decoration: BoxDecoration(
	      				borderRadius: BorderRadius.circular(10),
	      		color: Colors.white,
	      			),
	         padding: EdgeInsets.only(left: 10,top: 10
              + 20, right: 10,bottom: 10
          ),
          margin: EdgeInsets.only(top: 45),
	        child: ConstrainedBox(
	          constraints: BoxConstraints(
	            maxWidth: MediaQuery.of(context).size.width / 1.2,
	            maxHeight: MediaQuery.of(context).size.height / 1.2,
	          ),
	          child: SingleChildScrollView(
	          	child: Column(
	          		crossAxisAlignment: CrossAxisAlignment.stretch,
	          	children: [
	          	SizedBox(height: 20),
	          		LineChartCreator(),
	          		SizedBox(height: 20),
	          		Padding(
	          			padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
	          			child: ElevatedButton(
									style: ElevatedButton.styleFrom(
										shape: StadiumBorder(),
                						primary: Color(0xFF601E06),
						                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
						                textStyle: GoogleFonts.poppins(
						                	textStyle: TextStyle(
						                	fontSize: 15,
						                	fontWeight: FontWeight.bold
						                ),
						                ),
						                elevation: 30
						            ),
									child: Text('Tutup', style: GoogleFonts.poppins()),
									onPressed: (){
										Navigator.pop(context);
									}, 
								),
	          		),
	          		SizedBox(height: 10)
	          	]
	          ),)
	        ),
	      ),
	      		Positioned(
				  left: 1,
				    right: 1,
				    child: CircleAvatar(
				      backgroundColor: Color(0xFFFFCD5E),
				      radius: 45,
				      child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: Icon(Icons.show_chart_outlined, size: 40, color: Color(0xFF601E06)),
              ),
				),
				)
	      	]
	      )
	   );
	}
}

class LineChartCreator extends StatefulWidget {
  @override
  _LineChartCreatorState createState() => _LineChartCreatorState();
}

class _LineChartCreatorState extends State<LineChartCreator> {
  List<Color> gradientColors = [
    //const Colors.yellow,
    //const Color(0xFF601E06),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xFFFFFFFF)),
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        //getDrawingHorizontalLine: (value) {
        //  return FlLine(
        //    color: const Color(0xFF601E06),
        //    strokeWidth: 1,
        //  );
        //},
        //getDrawingVerticalLine: (value) {
        //  return FlLine(
        //    color: const Color(0xff37434d),
        //    strokeWidth: 1,
        //  );
        //},
      ),
      axisTitleData: FlAxisTitleData(
        leftTitle: AxisTitle(
          titleText: "Absorbansi",
          showTitle: true,
          textStyle: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF601E06),
            fontWeight: FontWeight.w300,
          ),
        ),
        bottomTitle: AxisTitle(
          titleText: "Panjang Gelombang (nm)",
          showTitle: true,
          textStyle: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF601E06),
            fontWeight: FontWeight.w300,
          ),
        ),

      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 100,
          getTextStyles: (context, value) =>
              const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            if((value % 100) == 0)
            	return value.toInt().toString();
            return ''; 
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 200,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
          	if((value % 200) == 0)
            	return value.toInt().toString();
            return ''; 
          },
          reservedSize: 32,
          margin: 5,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF601E06),
            width: 4,
          ),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      //borderData:
          //FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 400,
      minY: 0,
      maxY: 1001,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 200),
            FlSpot(100, 900),
            FlSpot(200, 200),
            FlSpot(300, 200),
            FlSpot(400, 200),
            //FlSpot(8, 4),
            //FlSpot(9.5, 3),
            //FlSpot(11, 4),
          ],
          isCurved: true,
          colors: [
          	Color(0xFFFFCD5E)
         ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [
            	Color(0xFFFFCD5E).withOpacity(0.2),
            	Color(0xFFFFCD5E).withOpacity(0.2)
            ],
            gradientFrom: Offset(0, 1.0),
        	gradientTo: Offset(0, 0.0),
          ),
        ),
      ],
    );
  }
}
