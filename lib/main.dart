import 'package:flutter/material.dart';
import 'package:readcodigoqr/src/pages/home_page.dart';
import 'package:readcodigoqr/src/pages/mapa_page.dart';
import 'package:readcodigoqr/src/pages/qr_read.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'qr': (BuildContext context) => QrRead(),
        'mapa': (BuildContext context) => MapaPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
    );
  }
}
