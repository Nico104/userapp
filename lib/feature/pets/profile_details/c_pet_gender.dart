import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../general/utils_theme/custom_colors.dart';
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
            Flexible(
              child: GestureDetector(
                onTap: () => handleButtonPress(Gender.male),
                child: GenderButton(
                  isActive: gender == Gender.male,
                  label: "profileDetailsGenderButtonLabelMale".tr(),
                  activeColor:
                      getCustomColors(context).genderButtonEnabledMale!,
                ),
              ),
            ),
            SizedBox(width: 06.w),
            Flexible(
              child: GestureDetector(
                onTap: () => handleButtonPress(Gender.female),
                child: GenderButton(
                  isActive: gender == Gender.female,
                  label: "profileDetailsGenderButtonLabelFemale".tr(),
                  activeColor:
                      getCustomColors(context).genderButtonEnabledFemale!,
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
    required this.activeColor,
  });

  final bool isActive;
  final String label;
  final Color activeColor;

  @override
  State<GenderButton> createState() => _GenderButtonState();
}

class _GenderButtonState extends State<GenderButton> {
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
      elevation: widget.isActive ? 4 : 0,
      borderRadius: BorderRadius.circular(_borderRardius),
      child: AnimatedContainer(
        // height: _height,
        // width: _width,
        duration: _duration,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRardius),
          color: widget.isActive
              ? widget.activeColor
              : Colors.black.withOpacity(0.06),
        ),
        padding: EdgeInsets.all(12),
        child: Center(
          child: Text(
            widget.label,
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
