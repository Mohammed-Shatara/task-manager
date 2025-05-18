import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/presentation/flows/app/root.dart';
import 'package:task_manager/presentation/flows/app/tasks/screens/add_task_screen.dart';
import 'package:task_manager/presentation/flows/app/tasks/screens/home_screen.dart';
import 'package:task_manager/presentation/flows/app/tasks/screens/task_details_screen.dart';
import 'package:task_manager/presentation/flows/app/tasks/screens/update_task_screen.dart';
import 'package:task_manager/presentation/flows/auth/screens/login_screen.dart';
import 'package:task_manager/presentation/flows/auth/screens/register_screen.dart';

import '../../app/di.dart';

import '../../presentation/flows/app/profile/screens/profile_screen.dart';
import '../../presentation/flows/intro/splash_screen.dart';
import '../blocs/app_bloc/app_bloc.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final sectionNavigatorKey = GlobalKey<NavigatorState>();

class RoutesPath {
  static String get splashScreen => '/';

  static String get homeScreen => '/root';

  static String taskDetailsScreen(String id) => '$homeScreen/task-details/$id';
  static String get createTaskScreen => '/create-task';
  static String updateTaskScreen(String id) => '/update-task/$id';

  static String get profilePage => '/profile';

  static String get loginPage => '/login';
  static String get registerPage => '$loginPage/register';
}

final router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: rootNavigatorKey,
  routes: routes,
  initialLocation: RoutesPath.splashScreen,
  refreshListenable: GoRouterRefreshStream(locator<AppBloc>().stream),
);

final List<RouteBase> routes = [
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    name: "splash",
    path: "/",
    builder: (context, state) {
      return const SplashScreen();
    },
    redirect: (context, goState) {
      if (locator<AppBloc>().state.appStatus == Status.unauthorized &&
          goState.matchedLocation == RoutesPath.splashScreen) {
        if (locator<AppBloc>().state.isFirstTime) {
          return RoutesPath.loginPage;
        } else {
          return RoutesPath.loginPage;
        }
      } else if (locator<AppBloc>().state.appStatus == Status.authorized &&
          goState.matchedLocation == RoutesPath.splashScreen) {
        return RoutesPath.homeScreen;
      }
      return null;
    },
  ),

  GoRoute(
    name: 'create-task',
    path: '/create-task',
    builder: (context, state) {
      return AddTaskScreen();
    },
  ),

  GoRoute(
    name: 'update-task',
    path: '/update-task/:taskId',
    builder: (context, state) {
      return UpdateTaskScreen();
    },
  ),

  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    name: 'login-screen',
    path: '/login',
    builder: (context, state) => const LoginScreen(),
    redirect: (context, goRouterState) {
      if (locator<AppBloc>().state.appStatus == Status.authorized &&
          goRouterState.path == RoutesPath.loginPage) {
        return RoutesPath.homeScreen;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: 'register',
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
    ],
  ),
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return RootPageWidget(navigationShell);
    },
    branches: [
      StatefulShellBranch(
        initialLocation: '/root',
        navigatorKey: sectionNavigatorKey,
        // Add this branch routes
        // each routes with its sub routes if available e.g feed/uuid/details
        routes: <RouteBase>[
          GoRoute(
            path: '/root',
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'task-details/:taskId',
                builder: (context, state) => const TaskDetailsScreen(),
              ),
            ],
            redirect: (context, goRouterState) {
              if (locator<AppBloc>().state.appStatus == Status.unauthorized) {
                return RoutesPath.loginPage;
              }
              return null;
            },
          ),
        ],
      ),

      StatefulShellBranch(
        initialLocation: '/profile',
        routes: <RouteBase>[
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
            redirect: (context, goRouterState) {
              if (locator<AppBloc>().state.appStatus == Status.unauthorized) {
                return RoutesPath.loginPage;
              }
              return null;
            },
          ),
        ],
      ),
    ],
  ),
];

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
