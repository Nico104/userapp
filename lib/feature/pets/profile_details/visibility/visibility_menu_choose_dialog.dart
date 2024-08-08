import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/general/utils_color/hex_color.dart';
import 'package:userapp/general/widgets/custom_nico_modal.dart';

void showVisibilityOption(BuildContext context) {
  showCustomNicoModalBottomSheet(
    context: context,
    child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "sp_sendLocationDialog_Title".tr(),
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "sp_sendLocationDialog_Description".tr(),
            style: GoogleFonts.prompt(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 30),
          VisibilityOptionItem(
            onTap: () {},
            subtitle: "Send my GPS Location".tr(),
            title: "Resend Location".tr(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}

class VisibilityOptionItem extends StatelessWidget {
  const VisibilityOptionItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title, subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Resend Location".tr(),
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              Text(
                "Send my GPS Location".tr(),
                style: GoogleFonts.prompt(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: HexColor("#8A7861"),
                ),
              ),
            ],
          ),
        ),
        IgnorePointer(
          // child: RadioMenuButton<Color>(
          //   value: Colors.red,
          //   // shortcut: _redShortcut,
          //   groupValue: _backgroundColor,
          //   onChanged: (value) {},
          //   child: const Text('Red Background'),
          // ),
          child: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: HexColor("#8A7861"),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
            child: Text(
              "sp_sendLocationDialog_Option_Phone_Button".tr(),
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: HexColor("#8A7861"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
