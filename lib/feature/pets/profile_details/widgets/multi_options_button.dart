import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

class MultiOptionButton extends StatefulWidget {
  const MultiOptionButton({
    super.key,
    required this.options,
    required this.initialActiveIndex,
    required this.title,
  });

  @override
  State<MultiOptionButton> createState() => _MultiOptionButtonState();

  final List<Option> options;
  final int initialActiveIndex;
  final String title;
}

class _MultiOptionButtonState extends State<MultiOptionButton> {
  late int _activeOptionIndex;
  late final List<Option> _options;
  final double _borderRadius = 14;

  @override
  void initState() {
    super.initState();
    _activeOptionIndex = widget.initialActiveIndex;
    _options = widget.options;
  }

  List<Widget> generateOptionButton() {
    List<Widget> list = [];

    for (int i = 0; i < _options.length; i++) {
      bool isSelected = i == _activeOptionIndex;
      // String label ;
      Widget widget = Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            borderRadius: BorderRadius.circular(_borderRadius),
            elevation: isSelected ? 2 : 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  _activeOptionIndex = i;
                });
              },
              child: Container(
                //Try out otherwise it is what it is
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  color: isSelected
                      ? getCustomColors(context).accent
                      : Colors.transparent,
                  border: isSelected
                      ? null
                      : Border.all(
                          color: getCustomColors(context).lightBorder ??
                              Colors.transparent,
                          width: 1,
                        ),
                ),
                padding: EdgeInsets.all(10),
                child: Center(
                  child: AutoSizeText(
                    _options.elementAt(i).label,
                    maxLines: 1,
                    style: GoogleFonts.openSans(
                        fontSize: 18,
                        color: isSelected
                            ? Colors.white
                            : getCustomColors(context).accent?.withOpacity(0.5),
                        fontWeight: FontWeight.w600
                        // fontWeight: widget.isActive ? FontWeight.w500 : FontWeight.w400,
                        // color: widget.isActive
                        //     ? Colors.white.withOpacity(0.95)
                        //     : Colors.black.withOpacity(0.36),
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      list.add(widget);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: generateOptionButton(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class Option {
  String label;

  Option(
    this.label,
  );
}

class OptionButton extends StatefulWidget {
  const OptionButton({
    super.key,
    required this.activeColor,
    required this.label,
    required this.isActive,
    required this.inactiveColor,
  });

  final Color activeColor;
  final Color inactiveColor;
  final String label;
  final bool isActive;

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  final Duration _duration = const Duration(milliseconds: 125);

  final double _borderRardius = 28;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.isActive ? 2 : 0,
      borderRadius: BorderRadius.circular(_borderRardius),
      child: AnimatedContainer(
        // height: _height,
        // width: _width,
        duration: _duration,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRardius),
            color: widget.isActive ? widget.activeColor : Colors.transparent,
            border: Border.all(
              color:
                  widget.isActive ? Colors.transparent : widget.inactiveColor,
              width: 2,
            )),
        padding: EdgeInsets.all(4),
        child: Center(
          child: AutoSizeText(
            widget.label,
            maxLines: 1,
            style: GoogleFonts.openSans(
              fontSize: 18,
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
