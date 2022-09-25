import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../screens/detail_screen.dart';
import '../../screens/screen_a.dart';
import '../../screens/screen_b.dart';
import '../../screens/third_screen.dart';
import '../navigator_key.dart';
import 'animation.dart';
import 'scaffold_with_nav_bar.dart';

final goRoutesProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    navigatorKey: ref.watch(rootNavigatorKeyProvider),
    initialLocation: '/a',
    // routes の中身は ShellRoute か GoRoute がとれる
    routes: <RouteBase>[
      /// Application shell
      ShellRoute(
        navigatorKey: ref.watch(shellNavigatorKeyProvider),
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: <RouteBase>[
          /// The first screen to display in the bottom navigation bar.
          GoRoute(
            path: '/a',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildPageWithAnimation(page: const ScreenA());
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'details',
                builder: (BuildContext context, GoRouterState state) {
                  return const DetailsScreen(label: 'A');
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'third',
                    builder: (BuildContext context, GoRouterState state) {
                      return const ThirdScreen();
                    },
                  ),
                ],
              ),
            ],
          ),

          /// Displayed when the second item in the the bottom navigation bar is
          /// selected.
          GoRoute(
            path: '/b',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildPageWithAnimation(page: const ScreenB());
            },
            routes: <RouteBase>[
              /// Same as "/a/details", but displayed on the root Navigator by
              /// specifying [parentNavigatorKey]. This will cover both screen B
              /// and the application shell.
              GoRoute(
                path: 'details',
                parentNavigatorKey: ref.watch(rootNavigatorKeyProvider),
                builder: (BuildContext context, GoRouterState state) {
                  return const DetailsScreen(label: 'B');
                },
              ),
            ],
          ),
        ],
      ),
    ],
  ),
);
