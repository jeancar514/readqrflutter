import 'dart:async';

import 'package:readcodigoqr/src/models/scan_model.dart';

import '../provider/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    // Obtener Scans de la Base de datos
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>?>.broadcast();

  Stream<List<ScanModel>?> get scansStream => _scansController.stream;

  //----- Metodos -----//

  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }

  agregarScan(ScanModel scan) {
    DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }

  //-------------------//

  dispose() {
    _scansController.close();
  }
}

final scanBloc = new ScansBloc();
