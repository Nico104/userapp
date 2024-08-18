import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/general/utils_general.dart';

import '../../general/utils_custom_icons/custom_icons_icons.dart';
import '../../general/widgets/loading_indicator.dart';

class ShareSeppi extends StatefulWidget {
  const ShareSeppi(
      {super.key,
      required this.closeShareSeppi,
      // required this.petProfileId,
      required this.petProfileDetails});

  final VoidCallback closeShareSeppi;
  // final int petProfileId;
  final PetProfileDetails petProfileDetails;

  @override
  State<ShareSeppi> createState() => _ShareSeppiState();
}

class _ShareSeppiState extends State<ShareSeppi> {
  bool _copying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 10))
          .then((value) => widget.closeShareSeppi());
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.petProfileDetails.tag.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "ShareNoTagTitle".tr(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 16),
              Text(
                "ShareNoTagLabel".tr(
                    namedArgs: {"Karamba": widget.petProfileDetails.petName}),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      );
    }
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
                    await Future.delayed(const Duration(milliseconds: 1000));
                    await Clipboard.setData(ClipboardData(
                            text: sharingLink +
                                widget.petProfileDetails.profileId.toString()))
                        .whenComplete(() => widget.closeShareSeppi());
                  },
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.link,
                          size: 32,
                        ),
                        const SizedBox(width: 16),
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
                      'check out my dope dog $sharingLink${widget.petProfileDetails.profileId}',
                      subject: 'Look at my dope dog!',
                    ).whenComplete(() => widget.closeShareSeppi());
                  },
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CustomIcons.share_thin,
                          size: 32,
                        ),
                        const SizedBox(width: 16),
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
            const SizedBox(
                width: 32, height: 32, child: CustomLoadingIndicatior()),
            const SizedBox(width: 16),
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
