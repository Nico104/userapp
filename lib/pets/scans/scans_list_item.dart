import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/models/m_scan.dart';

class ScanItem extends StatelessWidget {
  const ScanItem({
    super.key,
    required this.scan,
  });

  final Scan scan;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(scan.scanIpAddress),
    );
  }
}
