import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:userapp/pets/share/u_share.dart';
import 'package:userapp/styles/custom_icons_icons.dart';
import 'package:flutter/services.dart';

import 'm_share_background_style.dart';

class ShareImageGenerator extends StatefulWidget {
  const ShareImageGenerator({
    Key? key,
    required this.petProfileDetails,
  }) : super(key: key);

  final PetProfileDetails petProfileDetails;

  @override
  State<ShareImageGenerator> createState() => _ShareImageGeneratorState();
}

class _ShareImageGeneratorState extends State<ShareImageGenerator> {
  late List<ShareBackgroundStyle> _backgroundStyles;
  int _backgroundStyle = 0;

  final double _borderRadius = 16;

  @override
  void initState() {
    super.initState();
    _backgroundStyles = getShareBackgroundStyles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(12),
          child: InkWell(
            onTap: () {
              setState(() {
                if (_backgroundStyle < _backgroundStyles.length - 1) {
                  _backgroundStyle++;
                } else {
                  _backgroundStyle = 0;
                }
              });
            },
            borderRadius: BorderRadius.circular(28),
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              decoration: _backgroundStyles
                  .elementAt(_backgroundStyle)
                  .labelBoxDecoration,
              child: Text(
                _backgroundStyles.elementAt(_backgroundStyle).label,
                style: _backgroundStyles
                    .elementAt(_backgroundStyle)
                    .labelTextStyle,
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        // padding: EdgeInsets.all(16),
        height: double.infinity,
        width: double.infinity,
        decoration: _backgroundStyles
            .elementAt(_backgroundStyle)
            .qrBackgroundBoxDecoration,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                borderRadius: BorderRadius.circular(_borderRadius),
                elevation: 8,
                child: Container(
                  width: 80.w,
                  // height: 80.w,
                  padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(_borderRadius),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QrImage(
                        foregroundColor: _backgroundStyles
                            .elementAt(_backgroundStyle)
                            .qrCodeColor,
                        // size: 60.w,
                        data: 'This is a simple QR code',
                        version: QrVersions.auto,
                        gapless: true,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        widget.petProfileDetails.petName,
                        style: _backgroundStyles
                            .elementAt(_backgroundStyle)
                            .nameTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Material(
                borderRadius: BorderRadius.circular(_borderRadius),
                elevation: 8,
                child: Container(
                  width: 80.w,
                  // height: 80.w,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(_borderRadius),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShareOptionButton(
                        label: "Share Profile",
                        icon: const Icon(
                          CustomIcons.share_thin,
                          size: 28,
                        ),
                        onTap: () async {
                          //  ' Share.share(
                          //     'check out my dope ass dog\nhttps://example.com',
                          //     subject: 'Look at my dope ass dog!',
                          //   );
                          //
                          generateImage(
                            borderRadius: _borderRadius,
                            shareBackgroundStyle:
                                _backgroundStyles.elementAt(_backgroundStyle),
                            petName: widget.petProfileDetails.petName,
                          ).then((value) {
                            onShareXFileFromAssets(value);
                          });
                        },
                      ),
                      ShareOptionButton(
                        label: "Copy Link",
                        icon: const Icon(
                          Icons.link,
                          size: 28,
                        ),
                        onTap: () async {
                          await Clipboard.setData(
                              ClipboardData(text: "your text"));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onShareXFileFromAssets(Uint8List image) async {
    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // final data = await rootBundle.load('assets/flutter_logo.png');
    // final buffer = data.buffer;
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          // buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          image,
          name: 'flutter_logo.png',
          mimeType: 'image/png',
        ),
      ],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Share result: ${result.status}"),
          if (result.status == ShareResultStatus.success)
            Text("Shared to: ${result.raw}")
        ],
      ),
    );
  }
}

class ShareOptionButton extends StatelessWidget {
  const ShareOptionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(128),
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            child: icon,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
