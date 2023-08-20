import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sizer/sizer.dart';

class TagScanner extends StatelessWidget {
  const TagScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: MobileScanner(
        overlay: Container(
          height: 70.w,
          width: 70.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2.5,
            ),
          ),
        ),
        // fit: BoxFit.contain,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          // for (final barcode in barcodes) {
          //   print('Barcode found! ${barcode.rawValue}');
          // }
          Navigator.pop(context, barcodes.first.rawValue);
        },
      ),
    );
  }
}
