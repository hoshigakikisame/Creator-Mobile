import 'package:creator/creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RodaKopiPage extends StatefulWidget {
	@override
	_RodaKopiPageState createState() => _RodaKopiPageState();
}

class _RodaKopiPageState extends State<RodaKopiPage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.white,
			appBar: AppBar(
            	backgroundColor: Color(0xFFFFCD5E), 
            	elevation: 0.0,
            ),
			body: buildBody(),
		);
	}

	Widget buildBody() {
		return Container(
			height: double.infinity,
			color: Colors.white,
			child: Column(
				children: [
					Container(
						width: double.infinity,
						decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90.0),
                  bottomRight: Radius.circular(90.0)),
              color: Color(0xFFFFCD5E)),
					padding: EdgeInsets.only(top: 25, bottom: 50),
					child: Text(
                    'Roda Kopi',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                              ))
                            ),),
                  	SizedBox(height: 30),
					Expanded(child: Stack(
				children: [
					SpinningWheel(
					Image.asset('assets/images/wheel.png', width: 400, height: 400),
					width: 400,
					height: 400,
					dividers: 5,
					spinResistance: 0.6,
              		canInteractWhileSpinning: false,
					onUpdate: (value){
						return '';
					},
					onEnd: (value){
					}
				),
					Positioned(
					  left: 1,
					    right: 1,
					    top: -10,
					    child: Icon(
  						Icons.arrow_drop_down_outlined, size: 50,
						),
					)
				]
				)
			)
			]
			) 
		);
	}
}
