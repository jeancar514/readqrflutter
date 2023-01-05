import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:readcodigoqr/src/bloc/scans_bloc.dart';
import 'package:readcodigoqr/src/provider/db_provider.dart';
import 'package:readcodigoqr/src/utils/utils.dart' as utils;

class QrRead extends StatefulWidget {
  @override
  State<QrRead> createState() => _QrReadState();
}

class _QrReadState extends State<QrRead> {
  final scansBloc = new ScansBloc();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;

  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _crearAppBar(),
      body: _qrScreem(),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        setState(() {
          result = scanData;
        });
        controller.dispose();
      },
      onDone: () {
        if (result != null) {
          if (result?.code != null) {
            final scan = ScanModel(valor: result?.code);
            scansBloc.agregarScan(scan);
            print("------------------------------------");
            print(" resultado del scan ");
            print(result?.code);
            print(scan.tipo);
            print("------------------------------------");
            utils.abrirScan(context, scan);
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
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

  _qrScreem() {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      child: AlertDialog(
        contentPadding: EdgeInsets.all(5.0),
        content: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result != null)
                    ? Text('QR : ${result!.code}')
                    : Text('QR es null'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
