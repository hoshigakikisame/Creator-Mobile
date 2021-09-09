import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:creator/creator.dart';

class AboutPage extends StatefulWidget {
	@override
	_AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
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
			              color: Color(0xFFFFCD5E)
			             ),
						padding: EdgeInsets.only(top: 25, bottom: 50),
						child: Text(
			                'Tentang Kami',
			                textAlign: TextAlign.center,
			                style: GoogleFonts.poppins(
	                    	    textStyle: TextStyle(
	                        		fontSize: 30,
	                        		fontWeight: FontWeight.bold
	                      		),
                        	)
                    	),
					),
					Expanded(child: SingleChildScrollView(child:  
					Container(
						padding: EdgeInsets.all(20),
						child: Column(
							children: [
								AboutItem(
									header: "Apa itu CREATOR?", 
									body: Text('Kepanjangan dari CREATOR adalah Coffee Grade  Detector yang merupakan aplikasi android untuk menampilkan hasil uji dan hasil analisis yang telah dilakukan oleh alat Smart Cup Detector. Sekaligus menyediakan fitur flavor wheel dan menyediakan informasi terbaru tentang kopi nasional maupun internasional.')
								),
								AboutItem(
									header: "Langkah Mudah Penilaian\nMutu Biji Kopi", 
									body: Column(children: [
										AboutItem(
										header: "A. Persiapan Sampel Kopi", 
										body: Text('1.	Biji kopi yang telah disangrai dan digrinding menjadi bubuk, kemudian ditimbang dengan perbandingan 1:18\n2.	air bersuhu 95 oC dituangkan ke dalam cangkir yang telah terisi bubuk kopi dan didiamkan selama 4 menit. Setelah itu, Kopi diaduk dengan perlahan dan krim yang ada pada permukaan kopi dibuang.\n3.	Kuvet dibersihkan terlebih dahulu dengan menggunakan air bersih dan dikeringkan. Kemudian sampel sebanyak 5 ml dimasukkan ke dalam kuvet dan sampel siap dimasukkan ke dalam alat'))
										,
										AboutItem(
										header: "B. Penggunaan Alat", 
										body: Text('1.	Hidupkan Smart Cup Detector dengan menekan tombol ON/OFF.\n2.	Buka aplikasi CREATOR\n3.	Klik ”Connect” untuk menyambungkan apliasi CREATOR dengan Smart Cup Detector. Tunggu hingga muncul status “connected” yang berarti alat sudah tersambung\n4.	Jika sudah terhubung klik tombol “Mulai Pengukuran”\n5.	Klik tombol trigger pada alat untuk memulai penilaian mutu kopi\n6.	Setelah proses selesai maka hasil akan langsung muncul'))
									])								
									),
								AboutItem(
									header: "Perawatan Instrumen", 
									body: Text('1. Letakkan di tempat yang kering dan longgar\n2. Jauhkan dari sinar matahari secara langsung\n3.	Cuci kuvet setiap selesai menggunakan\n4. Isi daya ketika habis dan segera lepaskan dari charger ketika telah penuh\n5. Lepas baterai jika tidak digunakan dalam waktu yang lama')
								),
								AboutItem(
									header: "LARANGAN", 
									body: Text('1. Jauhkan dari jangkauan anak kecil\n2. Jauhkan dari api / yang mudah terbakar\n3. Jangan dibanting\n4. Jauhkan dari air')
								),
							]
						),
					)
				))
			]
		)
	);
	}
}

class AboutItem extends StatefulWidget {

	String header;
	Widget body;

	AboutItem({
		required this.header,
		required this.body,
	});

	@override
	_AboutItemState createState() => _AboutItemState();
}

class _AboutItemState extends State<AboutItem> {

	bool isExpanded = false;

	@override
	Widget build(BuildContext context) {
		return Container(
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					InkWell(
						onTap: (){
							setState(() => isExpanded = !isExpanded);
						},
						child: Card(
							shadowColor: Colors.black.withOpacity(0.5),
							shape: RoundedRectangleBorder(
	    						borderRadius: BorderRadius.circular(10.0),
	  						),
	  						color: Colors.grey.shade200,
							//elevation: 8, 
							child: Padding(
								padding: EdgeInsets.all(20), 
								child: Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: [
										Text(widget.header, style: GoogleFonts.poppins(
	                    	    textStyle: TextStyle(
	                        		//fontSize: 30,
	                        		fontWeight: FontWeight.bold
	                      		),
                        	)),
										Icon(isExpanded ? Icons.expand_less : Icons.expand_more)
									],
								)
							)
						),
					),
					isExpanded ? Container(
						child: Padding(
								padding: EdgeInsets.all(20), 
								child: widget.body,
							)
					) : Container(),
				]
			)
		);
	}
}
