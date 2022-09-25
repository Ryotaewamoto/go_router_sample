import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// This function is used to navigate smoothly with using [BottomNavigationBar].
/// That [transitionDuration] argument is [Duration.zero] means no animation.
/// 
CustomTransitionPage<void> buildPageWithAnimation({required Widget page}) {
  return CustomTransitionPage<void>(
    child: page,
    transitionDuration: Duration.zero,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
  );
}
