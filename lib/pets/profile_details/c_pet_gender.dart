import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../styles/text_styles.dart';
import 'c_component_title.dart';
import 'models/m_pet_profile.dart';

class PetGenderComponent extends StatelessWidget {
  const PetGenderComponent(
      {super.key, required this.gender, required this.setGender});

  //Gender
  final Gender? gender;
  final ValueSetter<Gender> setGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ComponentTitle(text: "Gender"),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => setGender(Gender.male),
              child: GenderButton(
                isMale: true,
                isActive: gender == Gender.male,
                label: "Male",
              ),
            ),
            SizedBox(width: 06.w),
            GestureDetector(
              onTap: () => setGender(Gender.female),
              child: GenderButton(
                isMale: false,
                isActive: gender == Gender.female,
                label: "Female",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class GenderButton extends StatefulWidget {
  const GenderButton({
    super.key,
    required this.isMale,
    required this.isActive,
    required this.label,
  });

  final bool isMale;
  final bool isActive;
  final String label;

  @override
  State<GenderButton> createState() => _GenderButtonState();
}

class _GenderButtonState extends State<GenderButton> {
  final Duration _enableBackgroundDuration = const Duration(milliseconds: 1000);
  final Duration _disableBackgroundDuration = const Duration(milliseconds: 250);
  final Duration _containerDuration = const Duration(milliseconds: 250);

  late BoxDecoration enabledBoxDecoration;
  late BoxDecoration disabledBoxDecoration;
  late BoxDecoration backgroundBoxDecoration;

  final double _height = 60;
  late double _width;

  final double _borderradius = 28;

  @override
  void initState() {
    super.initState();

    _width = 40.w;

    enabledBoxDecoration = BoxDecoration(
      color: widget.isMale ? Colors.blue : Colors.pink,
      borderRadius: BorderRadius.circular(_borderradius),
    );
    disabledBoxDecoration = BoxDecoration(
      color: widget.isMale ? Colors.blue.shade200 : Colors.pink.shade200,
      borderRadius: BorderRadius.circular(_borderradius),
    );
    backgroundBoxDecoration = BoxDecoration(
      color: widget.isMale ? Colors.blue.shade800 : Colors.pink.shade800,
      borderRadius: BorderRadius.circular(_borderradius),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AnimatedPadding(
          padding: EdgeInsets.only(top: widget.isActive ? _height / 7.5 : 0),
          duration: widget.isActive
              ? _enableBackgroundDuration
              : _disableBackgroundDuration,
          curve: widget.isActive ? Curves.elasticOut : Curves.linear,
          child: AnimatedRotation(
            duration: widget.isActive
                ? _enableBackgroundDuration
                : _disableBackgroundDuration,
            turns: widget.isActive ? -0.01 : 0,
            curve: widget.isActive ? Curves.elasticOut : Curves.linear,
            child: Container(
              decoration: backgroundBoxDecoration,
              height: _height,
              width: _width,
            ),
          ),
        ),
        AnimatedContainer(
          duration: _containerDuration,
          decoration:
              widget.isActive ? enabledBoxDecoration : disabledBoxDecoration,
          height: _height,
          width: _width,
          child: Center(
            child: Text(
              widget.label,
              style: profileGenderLabel,
            ),
          ),
        ),
      ],
    );
  }
}
