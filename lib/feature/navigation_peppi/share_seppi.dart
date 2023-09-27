import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../general/utils_custom_icons/custom_icons_icons.dart';

class ShareSeppi extends StatefulWidget {
  const ShareSeppi({super.key, required this.closeShareSeppi});

  final VoidCallback closeShareSeppi;

  @override
  State<ShareSeppi> createState() => _ShareSeppiState();
}

class _ShareSeppiState extends State<ShareSeppi> {
  bool _copying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 10))
          .then((value) => widget.closeShareSeppi());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: !_copying
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      _copying = true;
                    });
                    await Future.delayed(Duration(milliseconds: 1000));
                    await Clipboard.setData(
                            const ClipboardData(text: "your text"))
                        .whenComplete(() => widget.closeShareSeppi());
                  },
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.link,
                          size: 32,
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Copy Link",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 80.w,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Divider(
                      color: Colors.black12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Share.share(
                      'check out my dope ass dog https://example.com',
                      subject: 'Look at my dope ass dog!',
                    ).whenComplete(() => widget.closeShareSeppi());
                  },
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CustomIcons.share_thin,
                          size: 32,
                        ),
                        SizedBox(width: 16),
                        Text(
                          "Share via Platform",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : CopyingLinkWidget(closeShareSeppi: widget.closeShareSeppi),
    );
  }
}

class CopyingLinkWidget extends StatelessWidget {
  const CopyingLinkWidget({super.key, required this.closeShareSeppi});

  final VoidCallback closeShareSeppi;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        closeShareSeppi();
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   Icons.link,
            //   size: 32,
            // ),
            SizedBox(width: 32, height: 32, child: CircularProgressIndicator()),
            SizedBox(width: 16),
            Text(
              "Copying..",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
