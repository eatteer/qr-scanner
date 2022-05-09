import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchUrl(BuildContext context, ScanModel scan) async {
  String url = scan.value;
  String type = scan.type!;
  if (type == 'http') {
    if (await canLaunch(url)) {
      await launch(url);
    }
    return;
  }

  Navigator.pushNamed(context, 'map', arguments: scan);
}
