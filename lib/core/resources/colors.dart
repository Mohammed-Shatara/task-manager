import 'package:flutter/material.dart';

enum AppThemeMode { dark, light }

abstract class AppThemeColors {
  Color get primary90;
  Color get primary80;
  Color get primary70;
  Color get primary60;
  Color get primary50;
  Color get primary40;
  Color get primary30;
  Color get primary20;
  Color get primary10;
  Color get light;
  Color get dark;
  Color get secondary90;
  Color get secondary80;
  Color get secondary70;
  Color get secondary60;
  Color get secondary50;
  Color get secondary40;
  Color get secondary30;
  Color get secondary20;
  Color get secondary10;
  Color get tertiary90;
  Color get tertiary80;
  Color get tertiary70;
  Color get tertiary60;
  Color get tertiary50;
  Color get tertiary40;
  Color get tertiary30;
  Color get tertiary20;
  Color get tertiary10;
  Color get error90;
  Color get error95;
  Color get error80;
  Color get error70;
  Color get error60;
  Color get error50;
  Color get error40;
  Color get error30;
  Color get error20;
  Color get error10;
  Color get neutral98;
  Color get neutral96;
  Color get neutral95;
  Color get neutral94;
  Color get neutral92;
  Color get neutral90;
  Color get neutral99;
  Color get neutral87;
  Color get neutral80;
  Color get neutral70;
  Color get neutral60;
  Color get neutral50;
  Color get neutral40;
  Color get neutral30;
  Color get neutral24;
  Color get neutral22;
  Color get neutral20;
  Color get neutral17;
  Color get neutral12;
  Color get neutral10;
  Color get neutral6;
  Color get neutral4;
  Color get neutralVariant95;
  Color get neutralVariant90;
  Color get neutralVariant80;
  Color get neutralVariant70;
  Color get neutralVariant60;
  Color get neutralVariant50;
  Color get neutralVariant40;
  Color get neutralVariant30;
  Color get neutralVariant20;
  Color get neutralVariant10;
  Color get success;
}

class LightModeColors extends AppThemeColors {
  @override
  Color get dark => const Color(0xff000000);

  @override
  Color get error10 => const Color(0xff410002);

  @override
  Color get error20 => const Color(0xff690005);

  @override
  Color get error30 => const Color(0xff93000A);

  @override
  Color get error40 => const Color(0xffBA1A1A);

  @override
  Color get error50 => const Color(0xffDE3730);

  @override
  Color get error60 => const Color(0xffFF5449);

  @override
  Color get error70 => const Color(0xffFF897D);

  @override
  Color get error80 => const Color(0xffFFB4AB);

  @override
  Color get error90 => const Color(0xffFFDAD6);

  @override
  Color get error95 => const Color(0xffFFEDEA);

  @override
  Color get light => const Color(0xffFFFFFF);

  @override
  Color get neutral10 => const Color(0xff1B1B1D);

  @override
  Color get neutral20 => const Color(0xff303032);

  @override
  Color get neutral30 => const Color(0xff464749);

  @override
  Color get neutral40 => const Color(0xff5E5E60);

  @override
  Color get neutral50 => const Color(0xff777779);

  @override
  Color get neutral60 => const Color(0xff919093);

  @override
  Color get neutral70 => const Color(0xffACABAD);

  @override
  Color get neutral80 => const Color(0xffC7C6C8);

  @override
  Color get neutral90 => const Color(0xffE4E2E4);

  @override
  Color get neutral99 => const Color(0xffFEFBFE);

  @override
  Color get neutralVariant10 => const Color(0xff191C20);

  @override
  Color get neutralVariant20 => const Color(0xff2E3035);

  @override
  Color get neutralVariant30 => const Color(0xff44474C);

  @override
  Color get neutralVariant40 => const Color(0xff5C5E64);

  @override
  Color get neutralVariant50 => const Color(0xff75777D);

  @override
  Color get neutralVariant60 => const Color(0xff8F9196);

  @override
  Color get neutralVariant70 => const Color(0xffA9ABB1);

  @override
  Color get neutralVariant80 => const Color(0xffC5C6CC);

  @override
  Color get neutralVariant90 => const Color(0xffE1E2E8);

  @override
  Color get neutralVariant95 => const Color(0xffEFF0F7);

  @override
  Color get primary10 => const Color(0xff001C39);

  @override
  Color get primary20 => const Color(0xff00315C);

  @override
  Color get primary30 => const Color(0xff1F4876);

  @override
  Color get primary40 => const Color(0xff3A608F);

  @override
  Color get primary50 => const Color(0xff5479A9);

  @override
  Color get primary60 => const Color(0xff6E93C5);

  @override
  Color get primary70 => const Color(0xff88ADE1);

  @override
  Color get primary80 => const Color(0xffA4C9FE);

  @override
  Color get primary90 => const Color(0xffA4C9FE);

  @override
  Color get secondary10 => const Color(0xff001F24);

  @override
  Color get secondary20 => const Color(0xff00363E);

  @override
  Color get secondary30 => const Color(0xff004E59);

  @override
  Color get secondary40 => const Color(0xff016875);

  @override
  Color get secondary50 => const Color(0xff2F828F);

  @override
  Color get secondary60 => const Color(0xff4D9CA9);

  @override
  Color get secondary70 => const Color(0xff6AB7C5);

  @override
  Color get secondary80 => const Color(0xff85D2E1);

  @override
  Color get secondary90 => const Color(0xffA2EFFE);

  @override
  Color get tertiary10 => const Color(0xff271430);

  @override
  Color get tertiary20 => const Color(0xff3D2947);

  @override
  Color get tertiary30 => const Color(0xff543F5E);

  @override
  Color get tertiary40 => const Color(0xff6D5677);

  @override
  Color get tertiary50 => const Color(0xff876E91);

  @override
  Color get tertiary60 => const Color(0xffA288AC);

  @override
  Color get tertiary70 => const Color(0xffBDA2C7);

  @override
  Color get tertiary80 => const Color(0xffD9BDE3);

  @override
  Color get tertiary90 => const Color(0xffF6D9FF);

  @override
  Color get neutral12 => const Color(0xff1D2024);
  @override
  Color get neutral17 => const Color(0xff272A2F);

  @override
  Color get neutral22 => const Color(0xff32353A);

  @override
  Color get neutral24 => const Color(0xff37393E);

  @override
  Color get neutral4 => const Color(0xff0C0E13);

  @override
  Color get neutral6 => const Color(0xff111318);

  @override
  Color get neutral87 => const Color(0xffD8DAE0);

  @override
  Color get neutral92 => const Color(0xffE7E8EE);

  @override
  Color get neutral94 => const Color(0xffEDEDF4);

  @override
  Color get neutral95 => const Color(0xffEFF0F7);

  @override
  Color get neutral96 => const Color(0xffF2F3FA);

  @override
  Color get neutral98 => const Color(0xffF8F9FF);

  @override
  Color get success => const Color(0xff29DE92);
}

class DarkModeColors extends AppThemeColors {
  @override
  Color get success => const Color(0xff29DE92);
  @override
  Color get dark => const Color(0xff000000);

  @override
  Color get error10 => const Color(0xff410002);

  @override
  Color get error20 => const Color(0xff690005);

  @override
  Color get error30 => const Color(0xff93000A);

  @override
  Color get error40 => const Color(0xffBA1A1A);

  @override
  // TODO: implement error50
  Color get error50 => const Color(0xffDE3730);

  @override
  // TODO: implement error60
  Color get error60 => const Color(0xffFF5449);

  @override
  // TODO: implement error70
  Color get error70 => const Color(0xffFF897D);

  @override
  // TODO: implement error80
  Color get error80 => const Color(0xffFFB4AB);

  @override
  // TODO: implement error90
  Color get error90 => const Color(0xffFFDAD6);

  @override
  // TODO: implement error90
  Color get error95 => const Color(0xffFFEDEA);

  @override
  // TODO: implement light
  Color get light => const Color(0xffFFFFFF);

  @override
  // TODO: implement neutral10
  Color get neutral10 => const Color(0xff1B1B1D);

  @override
  // TODO: implement neutral20
  Color get neutral20 => const Color(0xff303032);

  @override
  // TODO: implement neutral30
  Color get neutral30 => const Color(0xff464748);

  @override
  // TODO: implement neutral40
  Color get neutral40 => const Color(0xff5E5E60);

  @override
  // TODO: implement neutral50
  Color get neutral50 => const Color(0xff777779);

  @override
  // TODO: implement neutral60
  Color get neutral60 => const Color(0xff919092);

  @override
  // TODO: implement neutral70
  Color get neutral70 => const Color(0xffACABAD);

  @override
  // TODO: implement neutral80
  Color get neutral80 => const Color(0xffC7C6C8);

  @override
  // TODO: implement neutral90
  Color get neutral90 => const Color(0xffE4E2E4);

  @override
  Color get neutral99 => const Color(0xffFEFBFE);

  @override
  // TODO: implement neutralVariant10
  Color get neutralVariant10 => const Color(0xff191C20);

  @override
  // TODO: implement neutralVariant20
  Color get neutralVariant20 => const Color(0xff2E3035);

  @override
  // TODO: implement neutralVariant30
  Color get neutralVariant30 => const Color(0xff45474B);

  @override
  // TODO: implement neutralVariant40
  Color get neutralVariant40 => const Color(0xff5C5E63);

  @override
  // TODO: implement neutralVariant50
  Color get neutralVariant50 => const Color(0xff75777C);

  @override
  // TODO: implement neutralVariant60
  Color get neutralVariant60 => const Color(0xff8F9096);

  @override
  // TODO: implement neutralVariant70
  Color get neutralVariant70 => const Color(0xffAAABB0);

  @override
  // TODO: implement neutralVariant80
  Color get neutralVariant80 => const Color(0xffC5C6CC);

  @override
  // TODO: implement neutralVariant90
  Color get neutralVariant90 => const Color(0xffE2E2E8);

  @override
  // TODO: implement neutralVariant90
  Color get neutralVariant95 => const Color(0xffF0F0F6);

  @override
  // TODO: implement primary10
  Color get primary10 => const Color(0xff001C38);

  @override
  // TODO: implement primary20
  Color get primary20 => const Color(0xff093158);

  @override
  // TODO: implement primary30
  Color get primary30 => const Color(0xff274870);

  @override
  // TODO: implement primary40
  Color get primary40 => const Color(0xff406089);

  @override
  // TODO: implement primary50
  Color get primary50 => const Color(0xff5979A3);

  @override
  // TODO: implement primary60
  Color get primary60 => const Color(0xff7393BF);

  @override
  // TODO: implement primary70
  Color get primary70 => const Color(0xff8DADDB);

  @override
  // TODO: implement primary80
  Color get primary80 => const Color(0xffA8C9F7);

  @override
  // TODO: implement primary90
  Color get primary90 => const Color(0xffD3E4FF);

  @override
  // TODO: implement secondary10
  Color get secondary10 => const Color(0xff001F24);

  @override
  // TODO: implement secondary20
  Color get secondary20 => const Color(0xff00363D);

  @override
  // TODO: implement secondary30
  Color get secondary30 => const Color(0xff004F58);

  @override
  // TODO: implement secondary40
  Color get secondary40 => const Color(0xff006875);

  @override
  // TODO: implement secondary50
  Color get secondary50 => const Color(0xff008392);

  @override
  // TODO: implement secondary60
  Color get secondary60 => const Color(0xff2A9EAE);

  @override
  // TODO: implement secondary70
  Color get secondary70 => const Color(0xff4EB9CA);

  @override
  // TODO: implement secondary80
  Color get secondary80 => const Color(0xff6DD5E6);

  @override
  // TODO: implement secondary90
  Color get secondary90 => const Color(0xff9AF0FF);

  @override
  // TODO: implement tertiary10
  Color get tertiary10 => const Color(0xff231728);

  @override
  // TODO: implement tertiary20
  Color get tertiary20 => const Color(0xff382C3E);

  @override
  // TODO: implement tertiary30
  Color get tertiary30 => const Color(0xff504255);

  @override
  // TODO: implement tertiary40
  Color get tertiary40 => const Color(0xff68596E);

  @override
  // TODO: implement tertiary50
  Color get tertiary50 => const Color(0xff817287);

  @override
  // TODO: implement tertiary60
  Color get tertiary60 => const Color(0xff9C8BA1);

  @override
  // TODO: implement tertiary70
  Color get tertiary70 => const Color(0xffB7A5BC);

  @override
  // TODO: implement tertiary80
  Color get tertiary80 => const Color(0xffD3C0D8);

  @override
  // TODO: implement tertiary90
  Color get tertiary90 => const Color(0xffF0DCF5);

  @override
  // TODO: implement neutral12
  Color get neutral12 => const Color(0xff1D2024);
  @override
  // TODO: implement neutral17
  Color get neutral17 => const Color(0xff272A2F);

  @override
  // TODO: implement neutral22
  Color get neutral22 => const Color(0xff32353A);

  @override
  // TODO: implement neutral24
  Color get neutral24 => const Color(0xff37393E);

  @override
  // TODO: implement neutral4
  Color get neutral4 => const Color(0xff0C0E13);

  @override
  // TODO: implement neutral6
  Color get neutral6 => const Color(0xff111318);

  @override
  // TODO: implement neutral87
  Color get neutral87 => const Color(0xffD8DAE0);

  @override
  // TODO: implement neutral92
  Color get neutral92 => const Color(0xffE7E8EE);

  @override
  // TODO: implement neutral94
  Color get neutral94 => const Color(0xffEDEDF4);

  @override
  // TODO: implement neutral95
  Color get neutral95 => const Color(0xffF2F0F2);

  @override
  // TODO: implement neutral96
  Color get neutral96 => const Color(0xffF2F3FA);

  @override
  // TODO: implement neutral98
  Color get neutral98 => const Color(0xffF8F9FF);
}

class ThemeFactory {
  static AppThemeColors colorModeFactory(AppThemeMode appThemeMode) {
    switch (appThemeMode) {
      case AppThemeMode.light:
        return LightModeColors();
      case AppThemeMode.dark:
        return DarkModeColors();
      default:
        return LightModeColors();
    }
  }

  static ThemeMode currentTheme(AppThemeMode appThemeMode) {
    return appThemeMode == AppThemeMode.dark ? ThemeMode.dark : ThemeMode.light;
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
