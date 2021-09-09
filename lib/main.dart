import 'package:creator/creator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CREATOR',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        )
      ),
      routes: {
        '/': (context) => MainPage(),
      },
      builder: (context, navigator) {
        return navigator!;
      },
      debugShowCheckedModeBanner: false,

    );
  }
}
