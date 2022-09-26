import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_sample/screens/screen_a.dart';
import 'package:go_router_sample/screens/screen_b.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


/// 現在選択状態になっている下タブを管理する StateProvider。
final bottomTabStateProvider = StateProvider<BottomTab>((_) => bottomTabs[0]);

/// BottomTab の種別。
enum BottomTabEnum {
  A(label: 'A', location: ScreenA.location),
  B(label: 'B', location: ScreenB.location);

  const BottomTabEnum({
    required this.label,
    required this.location,
  });

  final String label;
  final String location;
}

/// MainPage の BottomNavigationBar の内容
class BottomTab {
  const BottomTab._({
    required this.index,
    required this.key,
    required this.bottomTabEnum,
  });

  final int index;
  final GlobalKey<NavigatorState> key;
  final BottomTabEnum bottomTabEnum;
}

/// BottomNavigationBarItem.icon に表示するウィジェットを提供するプロバイダ。
final bottomTabIconProvider = Provider.family<Widget, BottomTabEnum>((ref, bottomTabEnum) {
  switch (bottomTabEnum) {
    case BottomTabEnum.A:
      return const FaIcon(FontAwesomeIcons.amazon);
    case BottomTabEnum.B:
      return const FaIcon(FontAwesomeIcons.bus);
  }
});

/// MainPage に表示する BottomNavigationBarItem 一覧。
final bottomTabs = <BottomTab>[
  BottomTab._(
    index: 0,
    key: GlobalKey<NavigatorState>(),
    bottomTabEnum: BottomTabEnum.A,
  ),
  BottomTab._(
    index: 1,
    key: GlobalKey<NavigatorState>(),
    bottomTabEnum: BottomTabEnum.B,
  ),
];

/// BottomNavigationBarItem をタップしたときの処理を提供する Provider。
///
/// 現在表示している状態のタブをタップした場合は画面をすべて pop する。
final bottomNavigationBarItemOnTapProvider = Provider.family<void Function(int), BuildContext>(
  (ref, context) => (index) {
    FocusManager.instance.primaryFocus?.unfocus();
    final bottomTab = bottomTabs[index];
    ref.read(bottomTabStateProvider.notifier).update((state) => bottomTab);
    GoRouter.of(context).go(bottomTab.bottomTabEnum.location);
  },
);
