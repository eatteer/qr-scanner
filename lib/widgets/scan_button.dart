import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/providers/scans_provider.dart';
import 'package:qr_scanner/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
        String scanResult = await FlutterBarcodeScanner.scanBarcode(
            '#3d8b3f', 'Cancel', true, ScanMode.QR);

        if (scanResult == '-1') {
          return;
        }

        ScansProvider scansProvider =
            Provider.of<ScansProvider>(context, listen: false);
            
        ScanModel scan = await scansProvider.insertScan(scanResult);
        launchUrl(context, scan);
      },
    );
  }
}
