import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/home_page.dart';
import 'package:qr_scanner/pages/map_page.dart';
import 'package:qr_scanner/providers/scans_provider.dart';
import 'package:qr_scanner/providers/ui_provider.dart';

void main() => runApp(const QRScannerApp());

class QRScannerApp extends StatelessWidget {
  const QRScannerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => UIProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ScansProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Scanner',
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => const HomePage(),
          'map': (BuildContext context) => const MapPage()
        },
      ),
    );
  }
}
