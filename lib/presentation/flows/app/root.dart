import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:go_router/go_router.dart';
import 'package:task_manager/core/resources/constans.dart';



enum RootTabs { currency, converter, gold, settings }

class RootPageWidget extends StatelessWidget {
  const RootPageWidget(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Colors.black.withAlpha(26),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
            showUnselectedLabels: true,

            onTap: (index) {
              navigationShell.goBranch(index, initialLocation: true);
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(SvgKeys.activeHome),
                icon: SvgPicture.asset(SvgKeys.home),
                label: "home",
              ),

              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(SvgKeys.activeProfile),
                icon: SvgPicture.asset(SvgKeys.profile),
                label: "profile",
              ),
            ],
          ),
        ),
      ),

      // bottomNavigationBar: CustomSalomonBottomBar(
      //   selectedColorOpacity: 0,
      //   backgroundColor: locator<AppThemeColors>().backgroundColor,
      //   currentIndex: navigationShell.currentIndex,
      //   onTap: (index) {
      //     //Handle button tap
      //     // bloc.navigateTo(RootTabs.values[index]);
      //     // if ((navigationShell.shellRouteContext.routerState.matchedLocation ==
      //     //     RoutesPath.historyPlaybackPage ||
      //     //     navigationShell.shellRouteContext.routerState.matchedLocation ==
      //     //         RoutesPath.tripsPlaybackPage ||
      //     //     navigationShell.shellRouteContext.routerState.matchedLocation ==
      //     //         RoutesPath.vehiclePlaybackPage)) {
      //     //   if (context.canPop()) {
      //     //     context.pop();
      //     //   }
      //     // }
      //     // // if (navigationShell.shellRouteContext.routerState.matchedLocation ==
      //     // //     RoutesPath.profilePage) {
      //     // //   print('asdasdasdasdsadsd profilePage');
      //     // //   locator<ProfileBloc>().setAccountFragment(AccountManagementFragment.init);
      //     // //   locator<ProfileBloc>().setFragment(ProfileFragment.init);
      //     // //
      //     // // }
      //     //
      //     // if (index == 3) {
      //     //   isFromTabs = false;
      //     // } else {
      //     //   isFromTabs = true;
      //     // }
      //
      //     navigationShell.goBranch(index, initialLocation: true);
      //   },
      //   items: [
      //     CustomSalomonBottomBarItem(
      //       activeIcon: Icon(Icons.icecream_outlined),
      //       icon: Icon(Icons.icecream_outlined),
      //       title: Text("tab"),
      //     ),
      //     CustomSalomonBottomBarItem(
      //       activeIcon: Icon(Icons.icecream_outlined),
      //       icon: Icon(Icons.icecream_outlined),
      //       title: Text("tab"),
      //     ),
      //     CustomSalomonBottomBarItem(
      //       activeIcon: Icon(Icons.icecream_outlined),
      //       icon: Icon(Icons.icecream_outlined),
      //       title: Text("tab"),
      //     ),
      //     CustomSalomonBottomBarItem(
      //       activeIcon: Icon(Icons.icecream_outlined),
      //       icon: Icon(Icons.icecream_outlined),
      //       title: Text("tab"),
      //     ),
      //   ],
      // ),
    );
  }
}

// class RootPageWidget extends StatefulWidget {
//   const RootPageWidget({super.key, required this.navigationShell});
//
//   final StatefulNavigationShell navigationShell;
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _RootPageWidgetState createState() => _RootPageWidgetState();
// }
//
// class _RootPageWidgetState extends State<RootPageWidget> with TickerProviderStateMixin {
//
// }

/// CurvedNavigationBar Example
/*
 CurvedNavigationBar(
            color: locator<AppThemeColors>().primaryColor,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            // height: 75.sp,
            items: <NavBarItem>[
              NavBarItem(
                  widget: SvgPicture.asset(
                    ImagesKeys.rain,
                  ),
                  name: "Currency".tr(context)),
              NavBarItem(
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      ImagesKeys.rain3,
                    ),
                  ),
                  name: "Converter".tr(context)),
              NavBarItem(
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      ImagesKeys.rain1,
                    ),
                  ),
                  name: "Gold".tr(context)),
              NavBarItem(
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      ImagesKeys.rain2,
                    ),
                  ),
                  name: "settings".tr(context)),
            ],
            onTap: (index) {
              //Handle button tap
              bloc.navigateTo(RootTabs.values[index]);
            },
          ),
 */
