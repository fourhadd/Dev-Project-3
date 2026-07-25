// core/router/smooth_page_route.dart
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class SmoothPageRoute<T> extends CustomTransitionPage<T> {
  SmoothPageRoute({
    required LocalKey key,
    required Widget child,

    Duration duration = const Duration(milliseconds: 450),
  }) : super(
         key: key,
         child: child,
         transitionDuration: duration,
         reverseTransitionDuration: duration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return CupertinoPageTransition(
             primaryRouteAnimation: animation,
             secondaryRouteAnimation: secondaryAnimation,
             linearTransition: false,
             child: child,
           );
         },
       );
}
