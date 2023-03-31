import 'package:flutter/material.dart';

@immutable
class CustomTextStyles extends ThemeExtension<CustomTextStyles> {
  const CustomTextStyles({
    @required this.profileDetailsPetName,
    @required this.homePetName,
    @required this.homeWelcomeMessage,
    @required this.homeWelcomeUser,
    @required this.dataEditDialogButtonCancelStyle,
    @required this.dataEditDialogButtonSaveStyle,
    @required this.profileGenderLabel,
    @required this.profileDetailsTabLabelActive,
    @required this.profileDetailsTabLabelInactive,
    @required this.textFormFieldHint,
    @required this.textFormFieldLabel,
    @required this.authRegisterNowAction,
  });

  final TextStyle? profileDetailsPetName;
  final TextStyle? homePetName;
  final TextStyle? homeWelcomeMessage;
  final TextStyle? homeWelcomeUser;
  final TextStyle? dataEditDialogButtonCancelStyle;
  final TextStyle? dataEditDialogButtonSaveStyle;
  final TextStyle? profileGenderLabel;
  final TextStyle? profileDetailsTabLabelActive;
  final TextStyle? profileDetailsTabLabelInactive;

  final TextStyle? textFormFieldHint;
  final TextStyle? textFormFieldLabel;

  //Used for the not a Member text
  final TextStyle? authRegisterNowAction;

  @override
  CustomTextStyles copyWith({
    TextStyle? profileDetailsPetName,
    TextStyle? homePetName,
    TextStyle? homeWelcomeMessage,
    TextStyle? homeWelcomeUser,
    TextStyle? dataEditDialogButtonCancelStyle,
    TextStyle? dataEditDialogButtonSaveStyle,
    TextStyle? profileGenderLabel,
    TextStyle? profileDetailsTabLabelActive,
    TextStyle? profileDetailsTabLabelInactive,
    TextStyle? textFormFieldHint,
    TextStyle? textFormFieldLabel,
    TextStyle? authRegisterNowAction,
  }) {
    return CustomTextStyles(
      profileDetailsPetName:
          profileDetailsPetName ?? this.profileDetailsPetName,
      homePetName: homePetName ?? this.homePetName,
      homeWelcomeMessage: homeWelcomeMessage ?? this.homeWelcomeMessage,
      homeWelcomeUser: homeWelcomeUser ?? this.homeWelcomeUser,
      dataEditDialogButtonCancelStyle: dataEditDialogButtonCancelStyle ??
          this.dataEditDialogButtonCancelStyle,
      dataEditDialogButtonSaveStyle:
          dataEditDialogButtonSaveStyle ?? this.dataEditDialogButtonSaveStyle,
      profileGenderLabel: profileGenderLabel ?? this.profileGenderLabel,
      profileDetailsTabLabelActive:
          profileDetailsTabLabelActive ?? this.profileDetailsTabLabelActive,
      profileDetailsTabLabelInactive:
          profileDetailsTabLabelInactive ?? this.profileDetailsTabLabelInactive,
      textFormFieldHint: textFormFieldHint ?? this.textFormFieldHint,
      textFormFieldLabel: textFormFieldLabel ?? this.textFormFieldLabel,
      authRegisterNowAction:
          authRegisterNowAction ?? this.authRegisterNowAction,
    );
  }

  @override
  CustomTextStyles lerp(CustomTextStyles? other, double t) {
    if (other is! CustomTextStyles) {
      return this;
    }
    return CustomTextStyles(
      profileDetailsPetName: TextStyle.lerp(
        profileDetailsPetName,
        other.profileDetailsPetName,
        t,
      ),
      homePetName: TextStyle.lerp(
        homePetName,
        other.homePetName,
        t,
      ),
      homeWelcomeMessage: TextStyle.lerp(
        homeWelcomeMessage,
        other.homeWelcomeMessage,
        t,
      ),
      homeWelcomeUser: TextStyle.lerp(
        homeWelcomeUser,
        other.homeWelcomeUser,
        t,
      ),
      dataEditDialogButtonCancelStyle: TextStyle.lerp(
        dataEditDialogButtonCancelStyle,
        other.dataEditDialogButtonCancelStyle,
        t,
      ),
      dataEditDialogButtonSaveStyle: TextStyle.lerp(
        dataEditDialogButtonSaveStyle,
        other.dataEditDialogButtonSaveStyle,
        t,
      ),
      profileGenderLabel: TextStyle.lerp(
        profileGenderLabel,
        other.profileGenderLabel,
        t,
      ),
      profileDetailsTabLabelActive: TextStyle.lerp(
        profileDetailsTabLabelActive,
        other.profileDetailsTabLabelActive,
        t,
      ),
      profileDetailsTabLabelInactive: TextStyle.lerp(
        profileDetailsTabLabelInactive,
        other.profileDetailsTabLabelInactive,
        t,
      ),
      textFormFieldHint: TextStyle.lerp(
        textFormFieldHint,
        other.textFormFieldHint,
        t,
      ),
      textFormFieldLabel: TextStyle.lerp(
        textFormFieldLabel,
        other.textFormFieldLabel,
        t,
      ),
      authRegisterNowAction: TextStyle.lerp(
        authRegisterNowAction,
        other.authRegisterNowAction,
        t,
      ),
    );
  }
}

CustomTextStyles getCustomTextStyles(BuildContext context) {
  return Theme.of(context).extension<CustomTextStyles>()!;
}
