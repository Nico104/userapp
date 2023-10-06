import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../general/utils_theme/custom_colors.dart';
import '../../../../general/widgets/shy_button.dart';

class ChooseSystemTheme extends StatefulWidget {
  const ChooseSystemTheme({
    super.key,
    required this.isActive,
    required this.setSystemThemeActivity,
  });

  final bool isActive;
  final Function(bool) setSystemThemeActivity;

  @override
  State<ChooseSystemTheme> createState() => _ChooseSystemThemeState();
}

class _ChooseSystemThemeState extends State<ChooseSystemTheme> {
  final double _borderRadius = 32;
  final double _height = 55;

  // bool isActive = false;

  final Duration _duration = Duration(milliseconds: 125);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        // padding: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(18),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          onTap: () {
            // setState(() {
            //   widget.isActive = true;
            // });
            widget.setSystemThemeActivity(true);
          },
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
            elevation: widget.isActive ? 0 : 6,
            child: AnimatedContainer(
              duration: _duration,
              height: widget.isActive ? 90.h : _height,
              width: widget.isActive ? 100.w : 55.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
                color: widget.isActive
                    ? Theme.of(context).canvasColor
                    : getCustomColors(context).accent,
              ),
              child: AnimatedSwitcher(
                duration: _duration,
                child: !widget.isActive
                    ? Center(
                        child: AutoSizeText(
                          "Use System Theme",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Colors.white),
                          maxLines: 1,
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            "Using Device Theme",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "You are currently using your devices Theme",
                            style: Theme.of(context).textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ShyButton(
                            showUploadButton: true,
                            onTap: () {
                              // Navigator.pop(context);
                              // setState(() {
                              //   isActive = false;
                              // })
                              widget.setSystemThemeActivity(false);
                            },
                            label: "Change Theme",
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
