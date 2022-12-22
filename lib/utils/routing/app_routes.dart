import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_sample/pages/not_found_page.dart';
import 'package:go_router_sample/pages/sign_in_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app.dart';
import '../../features/auth.dart';
import '../../features/bottom_tab.dart';
import '../../pages/account_page.dart';
import '../../pages/product_page.dart';
import '../../pages/products_list_page.dart';
import '../../pages/third_screen.dart';
import '../exceptions/base.dart';
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
    initialLocation: ProductsListPage.path,
    routes: <RouteBase>[
      GoRoute(
        path: SignInPage.path,
        name: SignInPage.name,
        builder: (BuildContext context, GoRouterState state) {
          return const SignInPage(
            key: ValueKey(SignInPage.name),
          );
        },
      ),
      ShellRoute(
        navigatorKey: ref.watch(shellNavigatorKeyProvider),
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: ProductsListPage.path,
            name: ProductsListPage.name,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildPageWithAnimation(
                page: const ProductsListPage(
                  key: ValueKey(ProductsListPage.name),
                ),
              );
            },
          ),
          GoRoute(
            // English:
            // The details screen to display stacked on the inner Navigator.
            // This will cover screen A but not the application shell.
            // 日本語:
            // ここでは parentNavigatorKey を指定していないので、直前の key 、
            // すなわち shell の navigator key を取得するので
            // [BottomNavigationBar] が維持された状態で画面遷移する。
            path: ProductPage.path,
            name: ProductPage.name,
            builder: (BuildContext context, GoRouterState state) {
              return ProviderScope(
                overrides: <Override>[
                  goRouterStateProvider.overrideWithValue(state),
                ],
                child: const ProductPage(
                  key: ValueKey(ProductPage.name),
                ),
              );
            },
          ),
          GoRoute(
            path: ThirdScreen.location,
            builder: (BuildContext context, GoRouterState state) {
              return const ThirdScreen();
            },
          ),
          GoRoute(
            path: AccountPage.location,
            name: AccountPage.name,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return buildPageWithAnimation(page: const AccountPage());
            },
            routes: const <RouteBase>[
              // English:
              // Same as "/a/details", but displayed on the root Navigator by
              // specifying [parentNavigatorKey]. This will cover both screen B
              // and the application shell.
              // 日本語:
              // [parentNavigatorKey] に root の navigator key を指定することで、
              // BottomNavigation が挟まらない（= the application Shell の上にくる）
              // ように画面遷移する。
              // GoRoute(
              //   path: ProductPage.path,
              //   parentNavigatorKey: ref.watch(rootNavigatorKeyProvider),
              //   builder: (BuildContext context, GoRouterState state) {
              //     return const ProductPage();
              //   },
              // ),
            ],
          ),
        ],
      ),
    ],
    // サインインをしていなければサインイン画面に遷移することができ、
    // サインイン後はホームに戻ってくる。
    //
    redirect: (context, state) {
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      if (isLoggedIn) {
        if (state.location == SignInPage.path) {
          final bottomTab = bottomTabs[0];
          ref
              .read(bottomTabStateProvider.notifier)
              .update((state) => bottomTab);
          return ProductsListPage.path;
        }
      } else {
        return state.location;
      }
      return null;
    },
    refreshListenable:
        GoRouterRefreshStream(ref.watch(authProvider).authStateChanges()),
    // return SignInPage.path;
    // errorBuilder: (BuildContext context, GoRouterState state) {
    //   return const NotFoundPage();
    // },
  ),
);

final goRouterStateProvider = Provider<GoRouterState>(
  (_) => throw const AppException(message: 'データが見つかりませんでした。'),
);

/// This class was included
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
