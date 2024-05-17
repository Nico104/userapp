import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    @required this.accent,
    @required this.accentLessContrast,
    @required this.accentHighContrast,
    @required this.lightBorder,
    @required this.hardBorder,
    @required this.surface,
    @required this.lightShadow,
    @required this.secondaryAccent,
    @required this.error,
    this.genderButtonEnabledMale = const Color(0xFF93E4FF),
    this.genderButtonEnabledFemale = const Color(0xFFffb6c1),
    this.genderButtonDisabledMale = const Color(0xFFbae7f8),
    this.genderButtonDisabledFemale = const Color(0xFFFFD1DC),
    this.genderButtonBackgroundMale = const Color(0xFF44bdea),
    this.genderButtonBackgroundFemale = const Color(0xFFff668a),
  });

  final Color? accent;
  //? In dark mode accentLight might be needed for accentDark in Light mode and vice versa, name accordingly
  final Color? accentLessContrast;
  final Color? accentHighContrast;
  final Color? lightBorder;
  final Color? hardBorder;
  final Color? surface;
  final Color? lightShadow;
  final Color? secondaryAccent;

  //Gender Buttons
  final Color? genderButtonEnabledMale;
  final Color? genderButtonEnabledFemale;
  final Color? genderButtonDisabledMale;
  final Color? genderButtonDisabledFemale;
  final Color? genderButtonBackgroundMale;
  final Color? genderButtonBackgroundFemale;

  //Gender ButtonColors

  //TextFormField suffix

  final Color? error;

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
    Color? error,
  }) {
    return CustomColors(
      accent: accent ?? this.accent,
      accentLessContrast: accent ?? this.accentLessContrast,
      accentHighContrast: accent ?? this.accentHighContrast,
      lightBorder: lightBorder ?? this.lightBorder,
      hardBorder: hardBorder ?? this.hardBorder,
      surface: shadow ?? this.surface,
      lightShadow: lightShadow ?? this.lightShadow,
      genderButtonEnabledMale:
          genderButtonEnabledMale ?? this.genderButtonEnabledMale,
      genderButtonEnabledFemale:
          genderButtonEnabledFemale ?? this.genderButtonEnabledFemale,
      secondaryAccent: accentShadow ?? this.secondaryAccent,
      genderButtonDisabledMale:
          genderButtonDisabledMale ?? this.genderButtonDisabledMale,
      genderButtonDisabledFemale:
          genderButtonDisabledFemale ?? this.genderButtonDisabledFemale,
      genderButtonBackgroundMale:
          genderButtonBackgroundMale ?? this.genderButtonBackgroundMale,
      genderButtonBackgroundFemale:
          genderButtonBackgroundFemale ?? this.genderButtonBackgroundFemale,
      error: error ?? this.error,
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
      accentLessContrast: Color.lerp(
        accentLessContrast,
        other.accentLessContrast,
        t,
      ),
      accentHighContrast: Color.lerp(
        accentHighContrast,
        other.accentHighContrast,
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
      surface: Color.lerp(
        surface,
        other.surface,
        t,
      ),
      lightShadow: Color.lerp(
        lightShadow,
        other.lightShadow,
        t,
      ),
      secondaryAccent: Color.lerp(
        secondaryAccent,
        other.secondaryAccent,
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
      error: Color.lerp(
        error,
        other.error,
        t,
      ),
    );
  }
}

CustomColors getCustomColors(BuildContext context) {
  return Theme.of(context).extension<CustomColors>()!;
}
