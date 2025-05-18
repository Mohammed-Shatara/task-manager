import 'package:task_manager/core/helper/extensions/material_color_converter.dart';
import 'package:flutter/material.dart';
import './colors.dart';

class TranslationsKeys {
  static String get changeLanguage => "change_lang";
}

class GifKeys {
  static String get splashLogo => 'lib/assets/gif/splash-animation.gif';
}

class ImagesKeys {
  static String get authBackground => "lib/assets/images/background.png";

  static String get header => "lib/assets/images/png/header.png";

  static String get header2 => "lib/assets/images/png/header2.png";

  static String get drawerHeader => "lib/assets/images/png/drawer-header.png";
}

class SvgKeys {
  static String get activeHome => "lib/assets/icons/navbar/home-2.svg";
  static String get home => "lib/assets/icons/navbar/home.svg";

  static String get activeProfile => "lib/assets/icons/navbar/profile-2.svg";
  static String get profile => "lib/assets/icons/navbar/profile.svg";
}

class AppTheme {
  static ThemeData appThemeData(
    AppThemeColors appThemeColors,
    bool localeEn,
    Brightness brightness,
  ) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: appThemeColors.primary40,
        primary: appThemeColors.primary40,
        onPrimary: appThemeColors.light,
        primaryContainer: appThemeColors.primary90,
        onPrimaryContainer: appThemeColors.primary10,
        primaryFixed: appThemeColors.primary90,
        primaryFixedDim: appThemeColors.primary80,
        onPrimaryFixed: appThemeColors.primary10,
        onPrimaryFixedVariant: appThemeColors.primary30,
        secondary: appThemeColors.secondary40,
        onSecondary: appThemeColors.light,
        secondaryContainer: appThemeColors.secondary90,
        onSecondaryContainer: appThemeColors.secondary10,
        secondaryFixed: appThemeColors.secondary90,
        secondaryFixedDim: appThemeColors.secondary80,
        onSecondaryFixed: appThemeColors.secondary10,
        onSecondaryFixedVariant: appThemeColors.secondary30,
        tertiary: appThemeColors.tertiary40,
        onTertiary: appThemeColors.light,
        tertiaryContainer: appThemeColors.tertiary90,
        onTertiaryContainer: appThemeColors.tertiary10,
        tertiaryFixed: appThemeColors.tertiary90,
        tertiaryFixedDim: appThemeColors.tertiary80,
        onTertiaryFixed: appThemeColors.tertiary10,
        onTertiaryFixedVariant: appThemeColors.tertiary30,
        error: appThemeColors.error40,
        onError: appThemeColors.light,
        errorContainer: appThemeColors.error90,
        onErrorContainer: appThemeColors.error10,
        inverseSurface: appThemeColors.neutral20,
        onInverseSurface: appThemeColors.neutral95,
        inversePrimary: appThemeColors.primary80,
        surface: appThemeColors.neutral98,
        surfaceBright: appThemeColors.neutral98,
        surfaceDim: appThemeColors.neutral87,
        surfaceContainerLowest: appThemeColors.light,
        surfaceContainerLow: appThemeColors.neutral96,
        surfaceContainer: appThemeColors.neutral94,
        surfaceContainerHigh: appThemeColors.neutral92,
        surfaceContainerHighest: appThemeColors.neutral90,
        onSurface: appThemeColors.neutral10,
        onSurfaceVariant: appThemeColors.neutralVariant30,
        outline: appThemeColors.neutralVariant50,
        outlineVariant: appThemeColors.neutralVariant80,
        scrim: appThemeColors.dark,
        shadow: appThemeColors.dark,
        brightness: brightness,
      ),
      primaryColorDark: appThemeColors.primary80,
      primaryColorLight: appThemeColors.primary40,
      scaffoldBackgroundColor: appThemeColors.light,
      primaryColor: appThemeColors.primary40,

      primarySwatch: appThemeColors.primary40.toMaterialColor(),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xffF6F6F6),
        hintStyle: TextStyle(color: Color(0xff797979), fontSize: 13),
        constraints: BoxConstraints(minHeight: 42),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appThemeColors.primary40,
          fixedSize: const Size(double.infinity, 48),
          foregroundColor: appThemeColors.light,
          elevation: 0,
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),

      textTheme: appTextTheme(localeEn: true),

      // iconTheme: IconThemeData(
      //   color: appThemeColors.primaryColor,
      //   size: 18.sp,
      // ),
      // radioTheme: RadioThemeData(
      //     fillColor:
      //         WidgetStatePropertyAll<Color>(appThemeColors.primaryColor)),
      // listTileTheme: const ListTileThemeData(
      //   dense: true,
      // ),
      // floatingActionButtonTheme: FloatingActionButtonThemeData(
      //     backgroundColor: locator<AppThemeColors>().primaryColor),
      // dividerTheme:
      //     DividerThemeData(color: appThemeColors.lightGray, thickness: 0.4),
      // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //     backgroundColor: appThemeColors.primaryColor),
      // textTheme: appTextTheme(
      //     textColor: appThemeColors.primaryColor, localeEn: localeEn),
      // textButtonTheme: TextButtonThemeData(
      //   style:
      //       TextButton.styleFrom(foregroundColor: appThemeColors.primaryColor),
      // ),
      // progressIndicatorTheme:
      //     ProgressIndicatorThemeData(color: appThemeColors.primaryColor),
      // sliderTheme: SliderThemeData(
      //   activeTrackColor: appThemeColors.primaryColor,
      //   thumbColor: appThemeColors.primaryColor,
      //   //     thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0),
      //   //    overlayColor: appThemeColors.transparent,
      //   overlayShape: SliderComponentShape.noOverlay,
      // ),
      fontFamily: localeEn ? "Montserrat" : "Montserrat",
      brightness: brightness,
      useMaterial3: true,
    );
  }

  static TextTheme appTextTheme({Color? textColor, required bool localeEn}) =>
      TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: textColor,
          fontFamily: localeEn ? "roboto" : "roboto",
        ),
      );
}
