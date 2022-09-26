import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app.dart';
import '../../screens/detail_screen.dart';
import '../../screens/screen_a.dart';
import '../../screens/screen_b.dart';
import '../../screens/third_screen.dart';
import '../navigator_key.dart';
import 'animation.dart';
import 'scaffold_with_nav_bar.dart';


/// This [Provider] controls app routing with [GoRouter]. Particularly this
/// is used [App] class.
///
/// A [routes] argument takes a list of [GoRoute] or [ShellRoute] because
/// these classes extend [RouteBase]. Other argument [navigatorKey] is a key used specifying
/// parent key from below [GoRoute]. If you use [BottomNavigationBar], Two keys
/// [rootNavigatorKeyProvider] and [shellNavigatorKeyProvider] are necessary.
///
final goRoutesProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    navigatorKey: ref.watch(rootNavigatorKeyProvider),
    initialLocation: '/a',
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: ref.watch(shellNavigatorKeyProvider),
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/a',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildPageWithAnimation(page: const ScreenA());
            },
            routes: <RouteBase>[
              // English:
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              // 日本語:
              // ここでは parentNavigatorKey を指定していないので、直前の key 、
              // すなわち shell の navigator key を取得するので
              // [BottomNavigationBar] が維持された状態で画面遷移する。
              GoRoute(
                path: DetailsScreen.location,
                builder: (BuildContext context, GoRouterState state) {
                  return const DetailsScreen(label: 'a');
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: ThirdScreen.location,
                    builder: (BuildContext context, GoRouterState state) {
                      return const ThirdScreen();
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/b',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildPageWithAnimation(page: const ScreenB());
            },
            routes: <RouteBase>[
              // English:
              // Same as "/a/details", but displayed on the root Navigator by
              // specifying [parentNavigatorKey]. This will cover both screen B
              // and the application shell.
              // 日本語:
              // [parentNavigatorKey] に root の navigator key を指定することで、
              // BottomNavigation が挟まらない（= the application Shell の上にくる）
              // ように画面遷移する。
              GoRoute(
                path: DetailsScreen.location,
                parentNavigatorKey: ref.watch(rootNavigatorKeyProvider),
                builder: (BuildContext context, GoRouterState state) {
                  return const DetailsScreen(label: 'b');
                },
              ),
            ],
          ),
        ],
      ),
    ],
  ),
);
