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
  switchTheme: SwitchThemeData(),
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
        fontSize: 46,
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
        fontSize: 18,
        color: Colors.black.withOpacity(0.16),
      ),
      textFormFieldLabel: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 18,
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
      accent: HexColor("8F8FFF"),
      accentLight: HexColor("a9a9ff"),
      accentDark: HexColor("7676ff"),
      lightBorder: Colors.black.withOpacity(0.16),
      hardBorder: Colors.black,
      shadow: Colors.black.withOpacity(0.16),
      lightShadow: Colors.black.withOpacity(0.04),
      accentShadow: HexColor("7676ff").withOpacity(0.28),
    ),
  ],
);

///Dark Theme
final ThemeData constDarkTheme = ThemeData(
  primaryColor: Colors.green,
  brightness: Brightness.dark,
  dividerColor: Colors.black12,
  canvasColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.yellow,
    elevation: 0,
  ),
  extensions: const <ThemeExtension<dynamic>>[],
  // scaffoldBackgroundColor: darkModeBackground,
);
