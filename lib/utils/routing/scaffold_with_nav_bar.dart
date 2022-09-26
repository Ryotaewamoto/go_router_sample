import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/bottom_tab.dart';

class ScaffoldWithNavBar extends HookConsumerWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomTabs
            .map(
              (b) => BottomNavigationBarItem(
                icon: ref.watch(bottomTabIconProvider(b.bottomTabEnum)),
                label: b.bottomTabEnum.label,
              ),
            )
            .toList(),
        currentIndex: ref.watch(bottomTabStateProvider).index,
        onTap: (index) =>
            ref.read(bottomNavigationBarItemOnTapProvider(context))(index),
      ),
    );
  }
}
