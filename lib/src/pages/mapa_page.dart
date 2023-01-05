import 'package:flutter/material.dart';
import 'package:readcodigoqr/src/provider/db_provider.dart';

class MapaPage extends StatelessWidget {
  const MapaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        (ModalRoute.of(context)?.settings.arguments) as ScanModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.my_location),
          )
        ],
      ),
      body: Center(
        child: Text(scan.valor ?? " "),
      ),
    );
  }
}
