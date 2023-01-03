import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:readcodigoqr/src/provider/db_provider.dart';

class QrRead extends StatefulWidget {
  @override
  State<QrRead> createState() => _QrReadState();
}

class _QrReadState extends State<QrRead> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;

  QRViewController? controller;

  @override
  void reassemble() {
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      String? futureString = result?.code;
      //-------------------------------------------------
      if (result?.code != null) {
        final scan = ScanModel(valor: result?.code);
        DBProvider.db.nuevoScan(scan);
        print("------------------------------------");
        print(" resultado del scan ");
        print(result?.code);
        print("------------------------------------");
      }
      //-------------------------------------------------
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
