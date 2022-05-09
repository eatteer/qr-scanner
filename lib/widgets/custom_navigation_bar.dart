import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.currentBottomNavigationIndex;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Maps',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.web),
          label: 'Urls',
        )
      ],
      onTap: (index) {
        uiProvider.currentBottomNavigationIndex = index;
      },
    );
  }
}
