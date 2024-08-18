import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';
import '../utils_color/hex_color.dart';
import 'custom_text_styles.dart';

///Light Theme
final ThemeData constLightTheme = ThemeData(
  brightness: Brightness.light,

  appBarTheme: AppBarTheme(
    backgroundColor: HexColor("#F2F3F4"),
    foregroundColor: HexColor("040707"),
    elevation: 0,
    scrolledUnderElevation: 2,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'LibreBaskerville',
      fontSize: 20,
      color: HexColor("040707"),
    ),
    // surfaceTintColor: HexColor("#8A7861")
    // surfaceTintColor: HexColor("#F2F3F4"),
    surfaceTintColor: HexColor("#040707"),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      // systemNavigationBarColor: Colors.yellow,
      systemNavigationBarColor: HexColor("#F2F3F4"),
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ),

  //Used e.p. for SocialMediaContainer
  primaryColor: HexColor("#F2F3F4"),
  // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: HexColor("FF6B6B")),
  // primaryColorLight: ,
  primaryColorDark: HexColor("f3f3f3"),
  scaffoldBackgroundColor: HexColor("#F2F3F4"),

  //Used for Scaffold BG e.p.
  canvasColor: HexColor("#F2F3F4"),
  dividerTheme: DividerThemeData(
    color: HexColor("040707").withOpacity(0.25),
    thickness: 1,
  ),
  iconTheme: IconThemeData(color: HexColor("040707")),
  textTheme: TextTheme(
    //Login Welcome or Update Password Screen
    headlineLarge: TextStyle(
      fontFamily: 'LibreBaskerville',
      fontSize: 24,
      color: HexColor("040707"),
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Promt',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: HexColor("040707").withOpacity(0.84),
    ),
    //e.p. Settings Section Title
    // titleMedium: TextStyle(
    //   fontFamily: 'Segoe UI',
    //   fontSize: 18,
    //   fontWeight: FontWeight.w500,
    //   color: HexColor("040707").withOpacity(0.87),
    // ),
    titleMedium: GoogleFonts.openSans(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: HexColor("040707").withOpacity(0.95),
    ),
    //BasicInformation SectionTitle
    titleLarge: GoogleFonts.openSans(
      fontWeight: FontWeight.w700,
      fontSize: kIsWeb ? 24 : 16.sp,
      color: HexColor("040707").withOpacity(0.87),
    ),
    //e.p. Settings Item Label, Extended Actions
    labelMedium: GoogleFonts.prompt(
      // fontFamily: 'Promt',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: HexColor("040707").withOpacity(0.76),
    ),
    displaySmall: GoogleFonts.roboto(
      fontWeight: FontWeight.w200,
      fontSize: kIsWeb ? 16 : 10.5.sp,
      color: HexColor("040707").withOpacity(0.70),
    ),
    displayMedium: GoogleFonts.openSans(
      // fontFamily: 'Promt',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: HexColor("040707").withOpacity(0.9),
    ),
    displayLarge: GoogleFonts.openSans(
      fontWeight: FontWeight.w200,
      fontSize: 22,
      color: HexColor("040707").withOpacity(0.9),
    ),
    //Like Settings suffixText or Forgot Password
    // labelSmall: TextStyle(
    //   fontFamily: 'Promt',
    //   fontWeight: FontWeight.w400,
    //   fontSize: 14,
    //   color: Colors.black.withOpacity(0.64),
    // ),
    labelSmall: GoogleFonts.openSans(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: HexColor("040707").withOpacity(0.5),
    ),
    // Used for Button Labels
    labelLarge: GoogleFonts.prompt(
      fontWeight: FontWeight.w300,
      fontSize: kIsWeb ? 20 : 18,
      color: HexColor("040707").withOpacity(0.54),
    ),
  ),
  extensions: <ThemeExtension<dynamic>>[
    CustomTextStyles(
      profileDetailsPetName: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w600,
        fontSize: 32,
        color: HexColor("040707"),
      ),
      homePetName: TextStyle(
        fontFamily: 'Satisfy',
        fontSize: 38,
        color: HexColor("040707"),
      ),
      homeWelcomeMessage: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: HexColor("040707").withOpacity(0.56),
      ),
      homeWelcomeUser: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: HexColor("040707").withOpacity(0.87),
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
        color: Colors.white,
      ),
      //Free
      profileGenderLabel: const TextStyle(),
      //Free
      profileDetailsTabLabelActive: const TextStyle(),
      //Free
      profileDetailsTabLabelInactive: const TextStyle(),
      //Free
      textFormFieldHint: const TextStyle(),
      //Free
      textFormFieldLabel: const TextStyle(),
      //Free
      authRegisterNowAction: const TextStyle(),
    ),
    CustomColors(
      accent: HexColor("#040707"),
      accentHighContrast: HexColor("0D0D0D"),
      accentLessContrast: HexColor("0D0907"),
      // accent: HexColor("#8A7861"), //braun
      // accentLessContrast: HexColor("5478e4"), //blaui
      // accentHighContrast: HexColor("656bff"), //blaupurp

      lightBorder: HexColor("040707").withOpacity(0.16),
      hardBorder: HexColor("040707"),
      //Free
      // surface: Colors.white,
      surface: HexColor("#F2F3F4"),
      //Free
      lightShadow: HexColor("040707").withOpacity(0.04),
      secondaryAccent: HexColor("e14169"),
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
    titleTextStyle: const TextStyle(
      fontFamily: 'LibreBaskerville',
      fontSize: 20,
      color: Colors.white,
    ),
    surfaceTintColor: HexColor("#4169E1"),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      // systemNavigationBarColor: Colors.yellow,
      systemNavigationBarColor: HexColor("121212"),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  ),
  //Used e.p. for SocialMediaContainer
  primaryColor: HexColor("121212"),
  // primaryColorLight: HexColor("2c2c2c"),
  primaryColorDark: Colors.black,
  scaffoldBackgroundColor: HexColor("121212"),
  //Used for Scaffold BG e.p.
  canvasColor: HexColor("121212"),
  dividerTheme: const DividerThemeData(
    color: Colors.white,
    thickness: 1,
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: TextTheme(
    headlineLarge: const TextStyle(
      fontFamily: 'LibreBaskerville',
      fontSize: 24,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Promt',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.white.withOpacity(0.84),
    ),

    titleMedium: GoogleFonts.openSans(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white.withOpacity(0.95),
    ),
    //BasicInformation SectionTitle
    titleLarge: GoogleFonts.openSans(
      fontWeight: FontWeight.w700,
      fontSize: kIsWeb ? 24 : 16.sp,
      color: Colors.white.withOpacity(0.87),
    ),
    //e.p. Settings Item Label, Extended Actions
    labelMedium: GoogleFonts.prompt(
      // fontFamily: 'Promt',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.white.withOpacity(0.76),
    ),
    displaySmall: GoogleFonts.prompt(
      fontWeight: FontWeight.w200,
      fontSize: kIsWeb ? 16 : 10.5.sp,
      color: Colors.white.withOpacity(0.50),
    ),
    displayMedium: GoogleFonts.openSans(
      // fontFamily: 'Promt',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.white.withOpacity(0.9),
    ),
    displayLarge: GoogleFonts.openSans(
      fontWeight: FontWeight.w200,
      fontSize: 22,
      color: Colors.white.withOpacity(0.9),
    ),
    labelSmall: GoogleFonts.openSans(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: Colors.white.withOpacity(0.5),
    ),
    // Used for Button Labels
    labelLarge: GoogleFonts.prompt(
      fontWeight: FontWeight.w300,
      fontSize: kIsWeb ? 20 : 18,
      color: Colors.white.withOpacity(0.54),
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
        fontSize: 38,
        color: Colors.white,
      ),
      homeWelcomeMessage: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: Colors.white.withOpacity(0.56),
      ),
      homeWelcomeUser: TextStyle(
        fontFamily: 'Promt',
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: Colors.white.withOpacity(0.87),
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
      //Free
      profileGenderLabel: const TextStyle(),
      //Free
      profileDetailsTabLabelActive: const TextStyle(),
      //Free
      profileDetailsTabLabelInactive: const TextStyle(),
      //Free
      textFormFieldHint: const TextStyle(),
      //Free
      textFormFieldLabel: const TextStyle(),
      //Free
      authRegisterNowAction: const TextStyle(),
    ),
    CustomColors(
      //TODO accesscolor darkmdoe saturation - 20%
      accent: HexColor("4169E1"),
      accentLessContrast: HexColor("3a5eca"),
      accentHighContrast: HexColor("5478e4"),
      lightBorder: Colors.white.withOpacity(0.16),
      // hardBorder: Colors.white,
      hardBorder: Colors.white.withOpacity(0.6),
      surface: HexColor("1a1a1a"),
      lightShadow: Colors.white.withOpacity(0),
      secondaryAccent: HexColor("e1b941"),
      error: HexColor("CF6679"),
    ),
  ],
);
