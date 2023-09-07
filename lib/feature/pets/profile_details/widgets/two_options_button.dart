import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../general/utils_color/hex_color.dart';
import '../c_component_title.dart';

enum ActiveOption {
  inactive,
  option1,
  option2,
}

class TwoOptionButton extends StatefulWidget {
  const TwoOptionButton({
    super.key,
    required this.optionLabel1,
    required this.optionLabel2,
    required this.activeOption,
    this.activeColor,
    required this.onTap,
    required this.title,
  });

  @override
  State<TwoOptionButton> createState() => _TwoOptionButtonState();

  final String optionLabel1;
  final String optionLabel2;
  final ActiveOption activeOption;
  final Color? activeColor;
  final Function(int) onTap;
  final String title;
}

///Returns 0 if inactive, otherwise 1 or 2
class _TwoOptionButtonState extends State<TwoOptionButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComponentTitle(text: widget.title),
        Row(
          children: [
            InkWell(
              onTap: () {
                if (widget.activeOption == ActiveOption.option1) {
                  widget.onTap(0);
                } else {
                  widget.onTap(1);
                }
              },
              child: OptionButton(
                activeColor: widget.activeColor ?? HexColor("D2042D"),
                label: widget.optionLabel1,
                isActive: widget.activeOption == ActiveOption.option1,
              ),
            ),
            SizedBox(width: 05.w),
            InkWell(
              onTap: () {
                if (widget.activeOption == ActiveOption.option2) {
                  widget.onTap(0);
                } else {
                  widget.onTap(2);
                }
              },
              child: OptionButton(
                activeColor: widget.activeColor ?? HexColor("D2042D"),
                label: widget.optionLabel2,
                isActive: widget.activeOption == ActiveOption.option2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class OptionButton extends StatefulWidget {
  const OptionButton({
    super.key,
    required this.activeColor,
    required this.label,
    required this.isActive,
  });

  final Color activeColor;
  final String label;
  final bool isActive;

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  final Duration _duration = const Duration(milliseconds: 125);

  final double _height = 55;
  late double _width;

  @override
  void initState() {
    super.initState();
    _width = 35.w;
  }

  final double _borderRardius = 28;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.isActive ? 6 : 0,
      borderRadius: BorderRadius.circular(_borderRardius),
      child: AnimatedContainer(
        height: _height,
        width: _width,
        duration: _duration,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRardius),
          color: widget.isActive
              ? widget.activeColor
              : Colors.black.withOpacity(0.06),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: GoogleFonts.openSans(
              fontSize: 22,
              fontWeight: widget.isActive ? FontWeight.w500 : FontWeight.w400,
              color: widget.isActive
                  ? Colors.white.withOpacity(0.95)
                  : Colors.black.withOpacity(0.36),
            ),
          ),
        ),
      ),
    );
  }
}
