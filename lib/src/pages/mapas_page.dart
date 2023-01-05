import 'package:flutter/material.dart';
import 'package:readcodigoqr/src/provider/db_provider.dart';

import '../bloc/scans_bloc.dart';
import '../utils/utils.dart' as utils;

class MapasPage extends StatelessWidget {
  final scansBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanModel>?>(
      stream: scansBloc.scansStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ScanModel>?> snapshot) {
        print(snapshot.data?.length);
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final scans = snapshot.data;

        if (scans?.length == 0) {
          return Center(
            child: Text('No hay informacion'),
          );
        }
        return ListView.builder(
          itemCount: scans?.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            onDismissed: (direccion) => scansBloc.borrarScan(scans[i].id),
            background: Container(
              color: Color.fromARGB(255, 175, 146, 255),
            ),
            child: ListTile(
              onTap: () {
                utils.abrirScan(context, scans[i]);
              },
              leading: Icon(
                Icons.cloud_queue,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scans![i].valor ?? " "),
              subtitle: Text('ID : ${scans![i].id}'),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
