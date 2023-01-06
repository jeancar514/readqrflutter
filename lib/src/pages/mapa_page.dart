import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:readcodigoqr/src/provider/db_provider.dart';
import 'package:latlong2/latlong.dart';

class MapaPage extends StatefulWidget {
  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = new MapController();

  String tipoMapa = 'satellite';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        (ModalRoute.of(context)?.settings.arguments) as ScanModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              map.move(scan.getLatLong(), 15.0);
            },
            icon: Icon(Icons.my_location),
          )
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    LatLng? coord = scan.getLatLong();
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: coord,
        zoom: 15.0,
      ),
      children: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa() {
    return TileLayer(
      urlTemplate:
          'https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png256?access_token={accessToken}',
      additionalOptions: {
        'accessToken':
            'pk.eyJ1IjoiamVhbmNhcjUxNCIsImEiOiJjbGNpNHlkcGg2NXR1M3BwanltNnpzbnFyIn0.OOfUxROmdIvxQErwjOZxUQ',
        'id': 'mapbox.$tipoMapa'
      },
    );
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayer(
      markers: <Marker>[
        Marker(
          width: 120.0,
          height: 120.0,
          point: scan.getLatLong(),
          builder: (BuildContext context) => Container(
            child: Icon(
              Icons.location_on,
              size: 45.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }

  _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        if (tipoMapa == 'satellite') {
          tipoMapa = 'mapbox-streets-v8';
        } else if (tipoMapa == 'mapbox-streets-v8') {
          tipoMapa = 'country-boundaries-v1';
        } else if (tipoMapa == 'country-boundaries-v1') {
          tipoMapa = 'mapbox-bathymetry-v2';
        } else if (tipoMapa == 'mapbox-bathymetry-v2') {
          tipoMapa = 'naip';
        } else if (tipoMapa == 'naip') {
          tipoMapa = 'mapbox-terrain-v2';
        } else if (tipoMapa == 'mapbox-terrain-v2') {
          tipoMapa = 'mapbox-traffic-v1';
        } else if (tipoMapa == 'mapbox-traffic-v1') {
          tipoMapa = 'transit-v2';
        } else if (tipoMapa == 'transit-v2') {
          tipoMapa = 'satellite';
        }
        setState(() {
          tipoMapa;
        });
      },
    );
  }
}
