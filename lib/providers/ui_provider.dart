import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  int _currentBottomNavigationIndex = 0;

  int get currentBottomNavigationIndex {
    return _currentBottomNavigationIndex;
  }

  set currentBottomNavigationIndex(int index) {
    _currentBottomNavigationIndex = index;
    notifyListeners();
  }
}
