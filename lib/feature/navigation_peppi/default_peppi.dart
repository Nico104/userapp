import 'package:flutter/material.dart';

import '../../general/utils_custom_icons/custom_icons_icons.dart';

class DefaultPeppi extends StatelessWidget {
  const DefaultPeppi({
    super.key,
    required this.goToDetails,
    required this.goToScans,
    required this.goToShare,
  });

  final VoidCallback goToDetails;
  final VoidCallback goToScans;
  final VoidCallback goToShare;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 32),
        GestureDetector(
          onTap: () {
            goToShare();
            // setState(() {
            //   _share = true;
            // });
          },
          child: Container(
            //To trigger the Hit Box
            color: Colors.transparent,
            child: const Center(
              child: Icon(
                CustomIcons.share_thin,
                size: 32,
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        GestureDetector(
          onTap: () {
            goToDetails();
          },
          child: Container(
            //To trigger the Hit Box
            color: Colors.transparent,
            child: const Center(
              child: Icon(
                CustomIcons.edit,
                size: 32,
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        GestureDetector(
          onTap: () {
            goToScans();
          },
          child: Container(
            //To trigger the Hit Box
            color: Colors.transparent,
            child: const Center(
              child: Icon(
                // CustomIcons.edit_square,
                CustomIcons.qr_code_9,
                size: 32,
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
      ],
    );
  }
}
