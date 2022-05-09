import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/maps_page.dart';
import 'package:qr_scanner/pages/urls_page.dart';
import 'package:qr_scanner/providers/scans_provider.dart';
import 'package:qr_scanner/providers/ui_provider.dart';
import 'package:qr_scanner/widgets/scan_button.dart';
import 'package:qr_scanner/widgets/custom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scans'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ScansProvider scanListProvider =
                  Provider.of<ScansProvider>(context, listen: false);
              scanListProvider.deleteAllScans();
            },
          ),
        ],
      ),
      body: const _PageSwitcher(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _PageSwitcher extends StatelessWidget {
  const _PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* Consume UIProvider to change page using BottomNavigationBar index */
    UIProvider uiProvider = Provider.of<UIProvider>(context);
    int currentIndex = uiProvider.currentBottomNavigationIndex;

    switch (currentIndex) {
      case 0:
        return const MapsPage();
      case 1:
        return const UrlsPage();
      default:
        return const MapsPage();
    }
  }
}
