import 'package:flutter/material.dart';
import 'package:readcodigoqr/pages/mapas_page.dart';
import 'direcciones_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _crearAppBar(),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex, // cual esta activo
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          label: 'map',
          icon: Icon(Icons.map),
        ),
        BottomNavigationBarItem(
          label: 'Direction',
          icon: Icon(Icons.brightness_5),
        )
      ],
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: () {},
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  _crearAppBar() {
    return AppBar(
      title: Center(
        child: Text('QA scanner'),
      ),
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(Icons.delete_forever))
      ],
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  void _scanQR() async {
    String futureString = '';
    try {} catch (e) {
      String futureString = e.toString();
    }

    print('Future String $futureString ');
    if (futureString != null) {
      print('tenemos informacion');
    }
  }
}
