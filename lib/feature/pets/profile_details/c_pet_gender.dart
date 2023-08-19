import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../general/utils_theme/custom_colors.dart';
import '../../../general/utils_theme/custom_text_styles.dart';
import 'c_component_title.dart';
import 'models/m_pet_profile.dart';

class PetGenderComponent extends StatelessWidget {
  const PetGenderComponent(
      {super.key, required this.gender, required this.setGender});

  //Gender
  final Gender? gender;
  final ValueSetter<Gender> setGender;

  void handleButtonPress(Gender value) {
    if (gender == value) {
      setGender(Gender.none);
    } else {
      setGender(value);
    }
  }

  final double _borderradius = 12;
  final double _borderwidth = 1.5;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComponentTitle(text: "profileDetailsComponentTitleGender".tr()),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => handleButtonPress(Gender.male),
              child: GenderButton(
                isActive: gender == Gender.male,
                label: "profileDetailsGenderButtonLabelMale".tr(),
                enabledBoxDecoration: BoxDecoration(
                  color: getCustomColors(context).genderButtonEnabledMale,
                  borderRadius: BorderRadius.circular(_borderradius),
                  border: Border.all(
                    width: _borderwidth,
                    color: getCustomColors(context).lightBorder ??
                        Colors.transparent,
                  ),
                ),
                disabledBoxDecoration: BoxDecoration(
                  color: getCustomColors(context).genderButtonDisabledMale,
                  borderRadius: BorderRadius.circular(_borderradius),
                  border: Border.all(
                    width: _borderwidth,
                    color: getCustomColors(context).lightBorder ??
                        Colors.transparent,
                  ),
                ),
                backgroundBoxDecoration: BoxDecoration(
                  color: getCustomColors(context).genderButtonBackgroundMale,
                  borderRadius: BorderRadius.circular(_borderradius),
                  border: Border.all(
                    width: _borderwidth,
                    color: getCustomColors(context).lightBorder ??
                        Colors.transparent,
                  ),
                ),
              ),
            ),
            SizedBox(width: 06.w),
            GestureDetector(
              onTap: () => handleButtonPress(Gender.female),
              child: GenderButton(
                isActive: gender == Gender.female,
                label: "profileDetailsGenderButtonLabelFemale".tr(),
                enabledBoxDecoration: BoxDecoration(
                  color: getCustomColors(context).genderButtonEnabledFemale,
                  borderRadius: BorderRadius.circular(_borderradius),
                  border: Border.all(
                    width: _borderwidth,
                    color: getCustomColors(context).lightBorder ??
                        Colors.transparent,
                  ),
                ),
                disabledBoxDecoration: BoxDecoration(
                  color: getCustomColors(context).genderButtonDisabledFemale,
                  borderRadius: BorderRadius.circular(_borderradius),
                  border: Border.all(
                    width: _borderwidth,
                    color: getCustomColors(context).lightBorder ??
                        Colors.transparent,
                  ),
                ),
                backgroundBoxDecoration: BoxDecoration(
                  color: getCustomColors(context).genderButtonBackgroundFemale,
                  borderRadius: BorderRadius.circular(_borderradius),
                  border: Border.all(
                    width: _borderwidth,
                    color: getCustomColors(context).lightBorder ??
                        Colors.transparent,
                  ),
                ),
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
    required this.isActive,
    required this.label,
    required this.enabledBoxDecoration,
    required this.disabledBoxDecoration,
    required this.backgroundBoxDecoration,
  });

  final bool isActive;
  final String label;

  final BoxDecoration enabledBoxDecoration;
  final BoxDecoration disabledBoxDecoration;
  final BoxDecoration backgroundBoxDecoration;

  @override
  State<GenderButton> createState() => _GenderButtonState();
}

class _GenderButtonState extends State<GenderButton> {
  final Duration _enableBackgroundDuration = const Duration(milliseconds: 1000);
  final Duration _disableBackgroundDuration = const Duration(milliseconds: 250);
  final Duration _containerDuration = const Duration(milliseconds: 250);

  final double _height = 60;
  late double _width;

  @override
  void initState() {
    super.initState();
    _width = 40.w;
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
              decoration: widget.backgroundBoxDecoration,
              height: _height,
              width: _width,
            ),
          ),
        ),
        AnimatedContainer(
          duration: _containerDuration,
          decoration: widget.isActive
              ? widget.enabledBoxDecoration
              : widget.disabledBoxDecoration,
          height: _height,
          width: _width,
          child: Center(
            child: Text(
              widget.label,
              style: getCustomTextStyles(context).profileGenderLabel,
            ),
          ),
        ),
      ],
    );
  }
}
