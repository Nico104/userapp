import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../pet_color/hex_color.dart';
import '../styles/text_styles.dart';

class CustomBigButton extends StatelessWidget {
  const CustomBigButton({
    super.key,
    this.onTap,
    required this.label,
  });

  final void Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: HexColor("8F8FFF"),
          border: Border.all(
            width: 1,
            color: Colors.black.withOpacity(0.16),
            // strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 6,
              offset: const Offset(1, 3),
            ),
          ],
        ),
        child: Center(
            child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge,
        )),
      ),
    );
  }
}

class ContinueWithSocialMedia extends StatelessWidget {
  const ContinueWithSocialMedia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 36, right: 36),
          child: Opacity(
            opacity: 0.28,
            child: Row(
              children: [
                const Expanded(
                    child: Divider(color: Colors.black, thickness: 1)),
                SizedBox(width: 03.w),
                Text(
                  "or continue with",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(width: 03.w),
                const Expanded(
                    child: Divider(color: Colors.black, thickness: 1)),
              ],
            ),
          ),
        ),
        SizedBox(height: 02.h),
        Padding(
          padding: const EdgeInsets.only(left: 36, right: 36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SocialMediaContainer(),
              SocialMediaContainer(),
              SocialMediaContainer(),
            ],
          ),
        ),
        SizedBox(height: 03.h),
      ],
    );
  }
}

class SocialMediaContainer extends StatelessWidget {
  const SocialMediaContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.black.withOpacity(0.16),
          // strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 6,
            offset: const Offset(1, 3),
          ),
        ],
      ),
    );
  }
}
