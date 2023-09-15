import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

class ShyUploadButton extends StatelessWidget {
  const ShyUploadButton({
    super.key,
    required this.profileId,
    required this.showUploadButton,
    required this.onTap,
    required this.label,
  });

  final bool showUploadButton;
  final int profileId;
  final void Function() onTap;
  final String label;

  final double _borderRadius = 32;
  final double _height = 65;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AnimatedAlign(
        alignment: showUploadButton
            ? const Alignment(0.0, 1.0)
            : const Alignment(0.0, 3.0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
            onTap: () => onTap(),
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
              elevation: 6,
              child: Container(
                height: _height,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_borderRadius)),
                  // color: Theme.of(context).primaryColor.withOpacity(1),
                  color: getCustomColors(context).accent,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 32, right: 24),
                        child: Text(
                          label,
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          height: _height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(_borderRadius)),
                            // color: Theme.of(context).primaryColor.withOpacity(1),
                            color: getCustomColors(context).accentDark,
                          ),
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Icon(
                              Icons.file_upload_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
