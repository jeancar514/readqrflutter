import 'package:flutter/cupertino.dart';
import 'package:readcodigoqr/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> abrirScan(BuildContext context, ScanModel scan) async {
  if (scan.tipo!.startsWith('http')) {
    String urlString = scan.valor ?? " ";
    final Uri urlUri = Uri.parse(urlString);
    if (!await launchUrl(
      urlUri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch ${scan.valor}';
    }
  } else {
    print('es un mapa');
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
