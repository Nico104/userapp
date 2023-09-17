import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

class ShyButton extends StatelessWidget {
  const ShyButton({
    super.key,
    required this.showUploadButton,
    required this.onTap,
    required this.label,
    this.icon,
    this.bgColor,
    this.fontColor,
    this.iconBgColor,
  });

  final bool showUploadButton;
  final void Function() onTap;
  final String label;

  final double _borderRadius = 32;
  final double _height = 65;

  final Icon? icon;

  final Color? bgColor;
  final Color? iconBgColor;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
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
                  color: bgColor ?? getCustomColors(context).accent,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: icon != null
                            ? EdgeInsets.only(left: 32, right: 24)
                            : EdgeInsets.only(left: 32, right: 32),
                        child: Text(
                          label,
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: fontColor ?? Colors.white,
                          ),
                        ),
                      ),
                      icon != null
                          ? AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                height: _height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(_borderRadius)),
                                  // color: Theme.of(context).primaryColor.withOpacity(1),
                                  color: iconBgColor ??
                                      getCustomColors(context).accentDark,
                                ),
                                padding: EdgeInsets.all(8),
                                child: Center(
                                  child: icon,
                                ),
                              ),
                            )
                          : const SizedBox(),
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

void handleShyButtonShown({required Function(bool) setShowShyButton}) {
  //hideBar
  // setState(() {
  //   _showUploadButton = false;
  // });
  setShowShyButton(false);
  EasyDebounce.debounce(
    'handleShyButton',
    const Duration(milliseconds: 200),
    () {
      //shwoNavbar
      // setState(() {
      //   _showUploadButton = true;
      // });
      setShowShyButton(true);
    },
  );
}
