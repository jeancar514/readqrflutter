import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:readcodigoqr/src/provider/db_provider.dart';
import 'package:latlong2/latlong.dart';

class MapaPage extends StatelessWidget {
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
      body: _crearFlutterMap(scan),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    LatLng? coord = scan.getLatLong();
    return FlutterMap(
      options: MapOptions(
        center: coord,
        zoom: 10.0,
      ),
      children: [
        _crearMapa(),
      ],
    );
  }

  _crearMapa() {
    return TileLayer(
      urlTemplate: 'https://api.mapbox.com/v4/' +
          '{id}/{z}/{x}/{y}@2x.png?accss_tokens={accessToken}',
      additionalOptions: {
        'accssToken':
            'pk.eyJ1IjoiamVhbmNhcjUxNCIsImEiOiJjbGNpNHlkcGg2NXR1M3BwanltNnpzbnFyIn0.OOfUxROmdIvxQErwjOZxUQ',
        'id': 'mapbox.streets'
      },
    );
  }
}
