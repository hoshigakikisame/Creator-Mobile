import 'package:creator/creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
                color: Color(0xFFFFCD5E)),
            padding: EdgeInsets.only(top: 25, bottom: 50),
            child: Text(
              'Tentang Kami',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    AboutItem(
                      header: "Apa itu CREATOR?",
                      body: buildAbout1(),
                    ),
                    AboutItem(
                        header: "Langkah Mudah Penilaian\nMutu Biji Kopi",
                        body: Column(children: [
                          AboutItem(
                              header: "A. Persiapan Sampel Kopi",
                              body: buildAbout2()),
                          AboutItem(
                              header: "B. Penggunaan Alat", body: buildAbout3())
                        ])),
                    AboutItem(
                      header: "Perawatan Instrumen",
                      body: buildAbout4(),
                    ),
                    AboutItem(
                        header: "LARANGAN",
                        body: Text(
                            '1. Jauhkan dari jangkauan anak kecil\n2. Jauhkan dari api / yang mudah terbakar\n3. Jangan dibanting\n4. Jauhkan dari air')),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildAbout1() {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(
          textStyle: TextStyle(),
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: 'CREATOR '),
          TextSpan(
              text: '(Coffee Grade Detector) ',
              style: TextStyle(fontStyle: FontStyle.italic)),
          TextSpan(
              text:
                  'merupakan aplikasi android yang berfungsi untuk menampilkan hasil pengujian kualitas kopi menggunakan instrumen '),
          TextSpan(
              text: 'Smart Cup Detector',
              style: TextStyle(fontStyle: FontStyle.italic)),
          TextSpan(
              text:
                  '. Aplikasi ini dapat menampilkan grafik pengujian serta nilai dari setiap parameter serta hasil pengklasifikasian jenis dan kualitas kopi. Selain itu aplikasi ini juga dilengkapi dengan fitur roda kopi '),
          TextSpan(
              text: '(flavor wheel)',
              style: TextStyle(fontStyle: FontStyle.italic)),
          TextSpan(
              text:
                  ', prosedur pengujian, perawatan instrumen, serta larangan. Semoga bermanfaat.'),
        ],
      ),
    );
  }

  Widget buildAbout2() {
    return Text(
        '1. Sangrai biji kopi dan haluskan hingga menjadi bubuk\n2. Kemudian timbang sebanyak 10 gram dan masukkan ke dalam cangkir\n3. Siapkan air panas dengan suhu 95 oC\n4. Kemudian tuangkan ke dalam cangkir\n5. Diamkan selama 4 menit\n6. Aduk permukaan kopi secara perlahan\n7. Buang krim pada permukaan kopi\n8. Bersihkan kuvet menggunakan air bersih lalu dikeringkan\n9. Masukkan sampel ke dalam kuvet sebanyak 5 ml\n10. Masukkan kuvet ke dalam instrumen');
  }

  Widget buildAbout3() {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(
          textStyle: TextStyle(),
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
              text:
                  '1. Hidupkan instrumen dengan menekan tombol switch pada bagian atas gagang\n2. Buka aplikasi CREATOR\n3. Klik '),
          TextSpan(
              text: '”Connect” ',
              style: TextStyle(fontStyle: FontStyle.italic)),
          TextSpan(
              text:
                  'untuk menyambungkan aplikasi CREATOR dengan instrumen\n4. Tunggu hingga muncul notifikasi “connected” yang berarti instrumen sudah terhubung dengan aplikasi\n5. Jika sudah terhubung klik tombol “Mulai Pengukuran”\n6. Klik tombol trigger (berwarna merah) pada instrumen untuk memulai pengujian\n7. Setelah proses selesai maka hasil akan muncul'),
        ],
      ),
    );
  }

  Widget buildAbout4() {
    return Text(
        '1. Letakkan di tempat yang kering dan lapang\n2. Jauhkan dari sinar matahari secara langsung\n3. Cuci kuvet setiap selesai menggunakan\n4. Isi daya ketika habis\n5. Segera lepaskan dari charger ketika pengisian daya telah penuh\n6. Lepas baterai jika instrumen tidak digunakan dalam jangka waktu yang lama');
  }

  Widget buildAbout5() {
    return Text(
        '1. Jauhkan dari jangkauan anak kecil\n2. Jauhkan dari api / bahan yang mudah terbakar\n3. Jauhkan dari air\n4. Jangan dibanting');
  }
}

class AboutItem extends StatefulWidget {
  final String header;
  final Widget body;

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
            onTap: () {
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
                    Text(
                      widget.header,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            //fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(isExpanded ? Icons.expand_less : Icons.expand_more)
                  ],
                ),
              ),
            ),
          ),
          isExpanded
              ? Container(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: widget.body,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
