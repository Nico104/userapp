import 'package:flutter/material.dart';
import 'package:userapp/theme/custom_colors.dart';
import '../pet_color/hex_color.dart';
import 'custom_text_styles.dart';

///Light Theme
final ThemeData constLightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
    scrolledUnderElevation: 8,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'LibreBaskerville',
      fontSize: 20,
      color: Colors.black,
    ),
  ),
  //Used e.p. for SocialMediaContainer
  primaryColor: Colors.white,
  // primaryColorLight: ,
  primaryColorDark: HexColor("f3f3f3"),
  //Used for Scaffold BG e.p.
  canvasColor: Colors.white,
  dividerTheme: const DividerThemeData(
    color: Colors.black,
    thickness: 1,
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  textTheme: TextTheme(
    //Login Welcome or Update Password Screen
    headlineLarge: const TextStyle(
      fontFamily: 'LibreBaskerville',
      fontSize: 24,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Promt',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.black.withOpacity(0.84),
    ),
    //e.p. Settings Section Title
    titleMedium: TextStyle(
      fontFamily: 'Lora',
      fontSize: 20,
      color: Colors.black.withOpacity(0.87),
    ),
    //e.p. Settings Item Label, Extended Actions
    labelMedium: TextStyle(
      fontFamily: 'Promt',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.black.withOpacity(0.76),
    ),
    //Like Settings suffixText or Forgot Password
    labelSmall: TextStyle(
      fontFamily: 'Promt',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.black.withOpacity(0.64),
    ),
    // Used for Button Labels
    labelLarge: const TextStyle(
      fontFamily: 'Lora',
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: Colors.white,
    ),
  ),
  extensions: <ThemeExtension<dynamic>>[
    CustomTextStyles(
      profileDetailsPetName: const TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w600,
        fontSize: 32,
        color: Colors.black,
      ),
      homePetName: const TextStyle(
        fontFamily: 'Satisfy',
        fontSize: 38,
        color: Colors.black,
      ),
      homeWelcomeMessage: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.black.withOpacity(0.56),
      ),
      homeWelcomeUser: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.black.withOpacity(0.87),
      ),
      dataEditDialogButtonCancelStyle: const TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.grey,
      ),
      dataEditDialogButtonSaveStyle: const TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.black,
      ),
      profileGenderLabel: const TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: Colors.white,
      ),
      profileDetailsTabLabelActive: const TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: Colors.black,
      ),
      profileDetailsTabLabelInactive: const TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 20,
        color: Colors.black,
      ),
      textFormFieldHint: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.black.withOpacity(0.16),
      ),
      textFormFieldLabel: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.black.withOpacity(0.38),
      ),
      authRegisterNowAction: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.blue.shade700,
      ),
    ),
    CustomColors(
      accent: HexColor("2196F3"),
      accentLight: HexColor("a9a9ff"),
      accentDark: HexColor("90CAF9"),
      lightBorder: Colors.black.withOpacity(0.16),
      hardBorder: Colors.black,
      shadow: Colors.black.withOpacity(0.16),
      lightShadow: Colors.black.withOpacity(0.04),
      accentShadow: HexColor("7676ff").withOpacity(0.28),
      error: HexColor("B00020"),
    ),
  ],
);

///Dark Theme
final ThemeData constDarkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor("121212"),
    foregroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 8,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'LibreBaskerville',
      fontSize: 20,
      color: Colors.white,
    ),
  ),
  //Used e.p. for SocialMediaContainer
  primaryColor: HexColor("1f1f1f"),
  primaryColorLight: HexColor("2c2c2c"),
  primaryColorDark: Colors.black,
  //Used for Scaffold BG e.p.
  canvasColor: HexColor("121212"),
  dividerTheme: const DividerThemeData(
    color: Colors.white,
    thickness: 1,
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: TextTheme(
    //Login Welcome or Update Password Screen
    headlineLarge: const TextStyle(
      fontFamily: 'LibreBaskerville',
      fontSize: 24,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Promt',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.white.withOpacity(0.84),
    ),
    //e.p. Settings Section Title
    titleMedium: TextStyle(
      fontFamily: 'Lora',
      fontSize: 20,
      color: Colors.white.withOpacity(0.87),
    ),
    //e.p. Settings Item Label, Extended Actions
    labelMedium: TextStyle(
      fontFamily: 'Promt',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.white.withOpacity(0.9),
    ),
    //Like Settings suffixText or Forgot Password
    labelSmall: TextStyle(
      fontFamily: 'Promt',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.white.withOpacity(0.8),
    ),
    // Used for Button Labels
    labelLarge: const TextStyle(
      fontFamily: 'Lora',
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: Colors.black,
    ),
  ),
  extensions: <ThemeExtension<dynamic>>[
    CustomTextStyles(
      profileDetailsPetName: const TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w600,
        fontSize: 32,
        color: Colors.white,
      ),
      homePetName: const TextStyle(
        fontFamily: 'Satisfy',
        fontSize: 46,
        color: Colors.white,
      ),
      homeWelcomeMessage: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.white.withOpacity(0.7),
      ),
      homeWelcomeUser: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.white.withOpacity(1),
      ),
      dataEditDialogButtonCancelStyle: const TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.grey,
      ),
      dataEditDialogButtonSaveStyle: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.grey.shade800,
      ),
      profileGenderLabel: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Colors.grey.shade800,
      ),
      profileDetailsTabLabelActive: const TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: Colors.white,
      ),
      profileDetailsTabLabelInactive: const TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 20,
        color: Colors.white,
      ),
      textFormFieldHint: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: Colors.white.withOpacity(0.16),
      ),
      textFormFieldLabel: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: Colors.white.withOpacity(0.38),
      ),
      authRegisterNowAction: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.blue.shade400,
      ),
    ),
    CustomColors(
      //TODO accesscolor darkmdoe saturation - 20%
      accent: HexColor("90CAF9"),
      accentLight: HexColor("0D47A1"),
      accentDark: HexColor("BBDEFB"),
      lightBorder: Colors.white.withOpacity(0),
      hardBorder: Colors.white,
      shadow: Colors.white.withOpacity(0),
      lightShadow: Colors.white.withOpacity(0),
      accentShadow: HexColor("7676ff").withOpacity(0.28),
      error: HexColor("CF6679"),
    ),
  ],
);
