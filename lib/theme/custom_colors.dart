import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    @required this.accent,
    @required this.accentLight,
    @required this.accentDark,
    @required this.lightBorder,
    @required this.hardBorder,
    @required this.shadow,
    @required this.lightShadow,
    @required this.accentShadow,
    this.genderButtonEnabledMale = const Color(0xFF93E4FF),
    this.genderButtonEnabledFemale = const Color(0xFFffb6c1),
    this.genderButtonDisabledMale = const Color(0xFFbae7f8),
    this.genderButtonDisabledFemale = const Color(0xFFFFD1DC),
    this.genderButtonBackgroundMale = const Color(0xFF44bdea),
    this.genderButtonBackgroundFemale = const Color(0xFFff668a),
  });

  final Color? accent;
  final Color? accentLight;
  final Color? accentDark;
  final Color? lightBorder;
  final Color? hardBorder;
  final Color? shadow;
  final Color? lightShadow;
  final Color? accentShadow;

  //Gender Buttons
  final Color? genderButtonEnabledMale;
  final Color? genderButtonEnabledFemale;
  final Color? genderButtonDisabledMale;
  final Color? genderButtonDisabledFemale;
  final Color? genderButtonBackgroundMale;
  final Color? genderButtonBackgroundFemale;

  //Gender ButtonColors

  //TextFormField suffix

  @override
  CustomColors copyWith({
    Color? accent,
    Color? accentLight,
    Color? accentDark,
    Color? lightBorder,
    Color? hardBorder,
    Color? shadow,
    Color? lightShadow,
    Color? accentShadow,
    Color? genderButtonEnabledMale,
    Color? genderButtonEnabledFemale,
    Color? genderButtonDisabledMale,
    Color? genderButtonDisabledFemale,
    Color? genderButtonBackgroundMale,
    Color? genderButtonBackgroundFemale,
  }) {
    return CustomColors(
      accent: accent ?? this.accent,
      accentLight: accent ?? this.accentLight,
      accentDark: accent ?? this.accentDark,
      lightBorder: lightBorder ?? this.lightBorder,
      hardBorder: hardBorder ?? this.hardBorder,
      shadow: shadow ?? this.shadow,
      lightShadow: lightShadow ?? this.lightShadow,
      genderButtonEnabledMale:
          genderButtonEnabledMale ?? this.genderButtonEnabledMale,
      genderButtonEnabledFemale:
          genderButtonEnabledFemale ?? this.genderButtonEnabledFemale,
      accentShadow: accentShadow ?? this.accentShadow,
      genderButtonDisabledMale:
          genderButtonDisabledMale ?? this.genderButtonDisabledMale,
      genderButtonDisabledFemale:
          genderButtonDisabledFemale ?? this.genderButtonDisabledFemale,
      genderButtonBackgroundMale:
          genderButtonBackgroundMale ?? this.genderButtonBackgroundMale,
      genderButtonBackgroundFemale:
          genderButtonBackgroundFemale ?? this.genderButtonBackgroundFemale,
    );
  }

  @override
  CustomColors lerp(CustomColors? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      accent: Color.lerp(
        accent,
        other.accent,
        t,
      ),
      accentLight: Color.lerp(
        accentLight,
        other.accentLight,
        t,
      ),
      accentDark: Color.lerp(
        accentDark,
        other.accentDark,
        t,
      ),
      lightBorder: Color.lerp(
        lightBorder,
        other.lightBorder,
        t,
      ),
      hardBorder: Color.lerp(
        hardBorder,
        other.hardBorder,
        t,
      ),
      shadow: Color.lerp(
        shadow,
        other.shadow,
        t,
      ),
      lightShadow: Color.lerp(
        lightShadow,
        other.lightShadow,
        t,
      ),
      accentShadow: Color.lerp(
        accentShadow,
        other.accentShadow,
        t,
      ),
      genderButtonEnabledMale: Color.lerp(
        genderButtonEnabledMale,
        other.genderButtonEnabledMale,
        t,
      ),
      genderButtonEnabledFemale: Color.lerp(
        genderButtonEnabledFemale,
        other.genderButtonEnabledFemale,
        t,
      ),
      genderButtonDisabledMale: Color.lerp(
        genderButtonDisabledMale,
        other.genderButtonDisabledMale,
        t,
      ),
      genderButtonDisabledFemale: Color.lerp(
        genderButtonDisabledFemale,
        other.genderButtonDisabledFemale,
        t,
      ),
      genderButtonBackgroundMale: Color.lerp(
        genderButtonBackgroundMale,
        other.genderButtonBackgroundMale,
        t,
      ),
      genderButtonBackgroundFemale: Color.lerp(
        genderButtonBackgroundFemale,
        other.genderButtonBackgroundFemale,
        t,
      ),
    );
  }
}

CustomColors getCustomColors(BuildContext context) {
  return Theme.of(context).extension<CustomColors>()!;
}
