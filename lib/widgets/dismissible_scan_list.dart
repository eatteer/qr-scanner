import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/providers/scans_provider.dart';
import 'package:qr_scanner/utils/utils.dart';

class DismissibleScanList extends StatelessWidget {
  const DismissibleScanList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScansProvider scansProvider = Provider.of<ScansProvider>(context);
    List<ScanModel> scans = scansProvider.scans;
    String selectedType = scansProvider.selectedType;
    int length = scans.length;

    return ListView.builder(
      itemCount: length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(color: Colors.red),
          onDismissed: (DismissDirection direction) {
            ScansProvider scanListProvider =
                Provider.of<ScansProvider>(context, listen: false);
            scanListProvider.deleteScanById(scans[index].id!);
          },
          child: ListTile(
            leading: selectedType == 'geo'
                ? const Icon(Icons.map)
                : const Icon(Icons.web),
            title: Text(
              scans[index].value,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => launchUrl(context, scans[index]),
          ),
        );
      },
    );
  }
}
