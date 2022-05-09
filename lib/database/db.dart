import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/* Singleton pattern */
class DBProvider {
  static Database? _db;
  static final DBProvider db = DBProvider._();

  /* Private constructor */
  DBProvider._();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ScansDB.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          );
        ''');
      },
    );
  }

  Future<int> insertScan(ScanModel scan) async {
    Database db = await database;
    int idLastRecord = await db.insert('Scans', scan.toJson());
    return idLastRecord;
  }

  Future<ScanModel?> selectScanById() async {
    Database db = await database;
    List<Map<String, dynamic>> res = await db.query('Scans');
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> selectScansByType(String type) async {
    Database db = await database;
    List<Map<String, dynamic>> scansFound = await db.query(
      'Scans',
      where: 'type = ?',
      whereArgs: [type],
    );
    return scansFound.isNotEmpty
        ? scansFound.map((scan) {
            return ScanModel.fromJson(scan);
          }).toList()
        : [];
  }

  Future<List<ScanModel>> selectAllScans() async {
    Database db = await database;
    List<Map<String, dynamic>> scansFound = await db.query('Scans');
    return scansFound.isNotEmpty
        ? scansFound.map((scan) {
            return ScanModel.fromJson(scan);
          }).toList()
        : [];
  }

  Future<int> updateScan(ScanModel scan) async {
    Database db = await database;
    int changesMade = await db.update(
      'Scans',
      scan.toJson(),
      where: 'id = ?',
      whereArgs: [scan.id],
    );
    return changesMade;
  }

  Future<int> deleteScanById(int id) async {
    Database db = await database;
    int rowsAffected = await db.delete(
      'Scans',
      where: 'id = ?',
      whereArgs: [id],
    );
    return rowsAffected;
  }

  Future<int> deleteAllScan() async {
    Database db = await database;
    int rowsAffected = await db.delete('Scans');
    return rowsAffected;
  }
}
