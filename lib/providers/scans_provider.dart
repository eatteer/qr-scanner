import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/database/db.dart';

class ScansProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'geo'; /* Default value */

  Future<ScanModel> insertScan(String value) async {
    ScanModel scan = ScanModel(value: value);
    int idLastRecord = await DBProvider.db.insertScan(scan);
    scan.id = idLastRecord;
    if (selectedType == scan.type) {
      scans.add(scan);
      notifyListeners();
    }
    return scan;
  }

  void selectAllScans() async {
    List<ScanModel> scans = await DBProvider.db.selectAllScans();
    scans = [...scans];
    notifyListeners();
  }

  void selectScansByType(String type) async {
    List<ScanModel> scans = await DBProvider.db.selectScansByType(type);
    this.scans = [...scans];
    selectedType = type;
    notifyListeners();
  }

  void deleteAllScans() async {
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }

  void deleteScanById(int id) async {
    await DBProvider.db.deleteScanById(id);
    /* It is not necessary to notifyListeners because the delete actions is made by dismissing */
  }
}
