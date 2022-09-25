import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rootNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (_) => GlobalKey<NavigatorState>(debugLabel: 'root'),
);

final shellNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (_) => GlobalKey<NavigatorState>(debugLabel: 'shell'),
);
