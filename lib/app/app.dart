import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import '../core/blocs/app_bloc/app_bloc.dart';
import '../core/navigation/routes.dart';
import '../core/resources/colors.dart';
import '../core/resources/constans.dart';
import 'di.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppBloc appBloc = locator<AppBloc>();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
    appBloc.add(LaunchAppEvent());
  }

  @override
  void dispose() {
    appBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => appBloc,
      child: BlocBuilder<AppBloc, AppState>(
        buildWhen: (previous, current) {
          return previous.appStatus == current.appStatus;
        },
        builder: (context, state) {
          return ToastificationWrapper(
            child: ScreenUtilInit(
              designSize: const Size(375, 830),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: 'Task Manager',
                  theme: AppTheme.appThemeData(
                    LightModeColors(),
                    true,
                    Brightness.light,
                  ),
                  darkTheme: AppTheme.appThemeData(
                    locator<AppThemeColors>(),
                    true,
                    Brightness.dark,
                  ),
                  themeMode: ThemeMode.light,
                  routerConfig: router,
                  builder: (context, child) {
                    return child ?? const SizedBox.shrink();
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
