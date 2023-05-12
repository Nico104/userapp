import 'package:flutter/material.dart';
import 'package:userapp/pets/scans/scans_list_item.dart';

import '../profile_details/models/m_scan.dart';

class ScansPage extends StatelessWidget {
  const ScansPage({
    Key? key,
    required this.petName,
    required this.scans,
  }) : super(key: key);

  final String petName;
  final List<Scan> scans;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Who scanned $petName"),
      ),
      body: ListView.builder(
        itemCount: scans.length,
        itemBuilder: (context, index) {
          return ScanItem(
            scan: scans.elementAt(index),
          );
        },
      ),
    );
  }
}
