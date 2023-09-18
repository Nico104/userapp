import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

class ContactVisibilitySwitch extends StatefulWidget {
  const ContactVisibilitySwitch({
    super.key,
  });

  @override
  State<ContactVisibilitySwitch> createState() =>
      _ContactVisibilitySwitchState();
}

class _ContactVisibilitySwitchState extends State<ContactVisibilitySwitch> {
  final double _borderRadius = 32;
  final double _height = 65;

  bool _isVisible = true;

  final _duration = const Duration(milliseconds: 125);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Align(
        alignment: const Alignment(0.0, 1.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
              elevation: 6,
              child: Container(
                height: _height,
                width: 50.w,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_borderRadius)),
                  color: Theme.of(context).primaryColor.withOpacity(1),
                  // color: bgColor ?? getCustomColors(context).accent,
                ),
                child: AnimatedAlign(
                  duration: _duration,
                  curve: Curves.fastOutSlowIn,
                  alignment:
                      _isVisible ? Alignment.centerRight : Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: AnimatedContainer(
                      duration: _duration,
                      curve: Curves.fastOutSlowIn,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius)),
                        color: _isVisible
                            ? getCustomColors(context).accent
                            : Colors.red.shade800,
                      ),
                      child: Center(
                          child: AnimatedSwitcher(
                        duration: _duration,
                        child: _isVisible
                            ? Text(
                                "Visible",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: Colors.white),
                              )
                            : Text(
                                "Hidden",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                      )),
                    ),
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
