import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/scans_provider.dart';
import 'package:qr_scanner/widgets/dismissible_scan_list.dart';

class UrlsPage extends StatelessWidget {
  const UrlsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScansProvider scanListProvider =
        Provider.of<ScansProvider>(context, listen: false);

    scanListProvider.selectScansByType('http');

    return const DismissibleScanList();
  }
}
