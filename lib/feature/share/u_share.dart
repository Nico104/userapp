import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:userapp/feature/share/m_share_background_style.dart';

Future<Uint8List> generateImage({
  required ShareBackgroundStyle shareBackgroundStyle,
  required double borderRadius,
  required String petName,
}) async {
  ScreenshotController screenshotController = ScreenshotController();

  double dimension = 720;

  Uint8List capturedImage = await screenshotController.captureFromWidget(
    AspectRatio(
      aspectRatio: 3 / 4,
      child: Container(
        // padding: EdgeInsets.all(16),
        padding: EdgeInsets.all(dimension * 0.07),
        height: dimension,
        decoration: shareBackgroundStyle.qrBackgroundBoxDecoration,
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(borderRadius),
            elevation: 8,
            child: Container(
              width: dimension * 0.8,
              // height: 80.w,
              padding: EdgeInsets.fromLTRB(
                  dimension * 0.1, dimension * 0.1, dimension * 0.1, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QrImageView(
                    foregroundColor: shareBackgroundStyle.qrCodeColor,
                    // size: 60.w,
                    data: 'This is a simple QR code',
                    version: QrVersions.auto,
                    gapless: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    petName,
                    style: shareBackgroundStyle.nameTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  return capturedImage;
}
